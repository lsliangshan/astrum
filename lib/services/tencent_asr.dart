import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

class TencentAsrService {
  final String secretId = dotenv.env['TENCENT_ASR_SECRET_ID'] ?? '';
  final String secretKey = dotenv.env['TENCENT_ASR_SECRET_KEY'] ?? '';
  final String appId = dotenv.env['TENCENT_ASR_APP_ID'] ?? '';
  final String engineModelType = '16k_zh';

  late AudioRecorder record;
  late IOWebSocketChannel channel;
  StreamSubscription? audioSubscription;
  StreamSubscription? wsSubscription;

  TencentAsrService() {
    record = AudioRecorder();
  }

  Map<String, String> buildHeaders({
    required int timestamp,
    required String voiceId,
  }) {
    return {
      'Authorization': generateAuthorizationHeader(
        timestamp: timestamp,
        voiceId: voiceId,
      ),
      'X-TC-Action': 'SentenceRecognition',
      'X-TC-Version': '2019-06-14',
      'X-TC-Timestamp': timestamp.toString(),
      'X-TC-Region': 'ap-guangzhou',
      'X-TC-EngineModelType': engineModelType,
      'Content-Type': 'audio/pcm; samplerate=16000',
    };
  }

  String generateAuthorizationHeader({
    required int timestamp,
    required String voiceId,
  }) {
    final nonce = Random().nextInt(10000);
    final signature = generateSignature(
      timestamp: timestamp,
      nonce: nonce,
      voiceId: voiceId,
    );

    return 'TC3-HMAC-SHA256 '
        'Credential=$secretId/${getDate()}/asr/tc3_request, '
        'SignedHeaders=content-type;host, '
        'Signature=$signature';
  }

  String generateSignature({
    required int timestamp,
    required int nonce,
    required String voiceId,
  }) {
    final rawString =
        "asr.cloud.tencent.com/asr/v2/$appId?engine_model_type=$engineModelType&expired=${timestamp + 24 * 60 * 60}&needvad=1&nonce=$nonce&secretid=$secretId&timestamp=$timestamp&voice_format=1&voice_id=$voiceId";
    final hmac = Hmac(sha1, utf8.encode(secretKey));
    final digest = hmac.convert(utf8.encode(rawString));
    return base64.encode(digest.bytes);
  }

  String getDate() {
    final now = DateTime.now().toUtc();
    return "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
  }

  IOWebSocketChannel connectWebSocket() {
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final voiceId = Uuid().v4();
    final nonce = Random().nextInt(10000);
    final signature = generateSignature(
      timestamp: timestamp,
      nonce: nonce,
      voiceId: voiceId,
    );

    return IOWebSocketChannel.connect(
      Uri.parse(
        'wss://asr.cloud.tencent.com/asr/v2/$appId?engine_model_type=$engineModelType&expired=${timestamp + 24 * 60 * 60}&needvad=1&nonce=$nonce&secretid=$secretId&timestamp=$timestamp&voice_format=1&voice_id=$voiceId&signature=${Uri.encodeComponent(signature)}',
        // 'wss://asr.cloud.tencent.com/asr/v2/$appId?engine_model_type=$engineModelType&expired=${timestamp + 24 * 60 * 60}&filter_dirty=1&filter_modal=1&filter_punc=1&needvad=1&nonce=$nonce&secretid=$secretId&timestamp=$timestamp&voice_format=1&voice_id=$voiceId&signature=${Uri.encodeComponent(signature)}',
      ),
      // headers: buildHeaders(timestamp: timestamp, voiceId: voiceId),
    );
  }

  void handleResponse(dynamic data, {Function(String)? onData}) {
    try {
      final jsonData = json.decode(data);
      if (jsonData['code'] == 0) {
        final result = jsonData['result'];
        final isEnd = jsonData['isEnd'] ?? false;
        print('识别结果: $result');
        onData?.call(result);

        if (isEnd) {
          stop(); // 收到最终结果后关闭连接
        }
      } else {
        print('识别错误: ${jsonData['message']}');
      }
    } catch (e) {
      print('响应解析错误: $e');
    }
  }

  Future<void> start({
    Function(String)? onData,
    Function()? onDone,
    Function(String)? onError,
  }) async {
    // 1. 初始化 WebSocket
    channel = connectWebSocket();

    // 2. 监听 WebSocket 响应
    wsSubscription = channel.stream.listen(
      (dynamic data) {
        try {
          final jsonData = json.decode(data);
          if (jsonData['code'] == 0) {
            final result = jsonData['result'];
            final isEnd = jsonData['isEnd'] ?? false;
            print('识别结果: $result');
            onData?.call(result.toString());

            if (isEnd) {
              stop(); // 收到最终结果后关闭连接
            }
          } else {
            print('识别错误: ${jsonData['message']}');
          }
        } catch (e) {
          print('响应解析错误: $e');
        }
      },
      onError: (error) {
        onError?.call(error.toString());
      },
      onDone: () {
        onDone?.call();
      },
    );

    if (await record.hasPermission()) {
      // 3. 开始录音
      final stream = await record.startStream(
        RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
      );

      // 4. 发送音频数据（每100ms发送3200字节）
      audioSubscription = stream.listen((Uint8List pcmData) {
        if (channel.closeCode == null) {
          // 分包发送（腾讯云要求每包约100ms音频）
          for (var i = 0; i < pcmData.length; i += 3200) {
            final end = i + 3200;
            final chunk = end < pcmData.length
                ? pcmData.sublist(i, end)
                : pcmData.sublist(i);

            channel.sink.add(chunk);
          }
        }
      });
    }
  }

  Future<void> stop() async {
    await audioSubscription?.cancel();
    await wsSubscription?.cancel();
    await record.stop();

    // 发送结束标记（空数据帧）
    if (channel.closeCode == null) {
      channel.sink.add(Uint8List(0)); // 发送结束标记
      await Future.delayed(Duration(milliseconds: 500)); // 等待最终结果
      channel.sink.close();
    }
  }
}
