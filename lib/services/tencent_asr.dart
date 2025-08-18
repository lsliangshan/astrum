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

  static AudioRecorder? record;
  IOWebSocketChannel? channel;
  StreamSubscription? audioSubscription;
  StreamSubscription? wsSubscription;

  bool isRunning = false;

  TencentAsrService() {
    record ??= AudioRecorder();
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
      ),
    );
  }

  void handleResponse(dynamic data, {Function(String)? onData}) {
    try {
      final jsonData = json.decode(data);
      if (jsonData['code'] == 0) {
        final result = jsonData['result'];
        final isEnd = jsonData['isEnd'] ?? false;

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
    Function(dynamic)? onData,
    Function()? onDone,
    Function(String)? onError,
  }) async {
    if (isRunning) {
      return;
    }

    isRunning = true;

    try {
      // 1. 初始化 WebSocket
      channel = connectWebSocket();

      // 2. 监听 WebSocket 响应
      wsSubscription = channel!.stream.listen(
        (dynamic data) {
          try {
            final jsonData = json.decode(data);
            if (jsonData['code'] == 0) {
              final result = jsonData['result'];
              final isEnd = jsonData['isEnd'] ?? false;

              onData?.call(result);

              if (isEnd) {
                onData?.call(null);
                stop(); // 收到最终结果后关闭连接
              }
            } else {
              onError?.call(jsonData['message']);
              print('识别错误: ${jsonData['message']}');
            }
          } catch (e) {
            onError?.call(e.toString());
            print('响应解析错误: $e');
          }
        },
        onError: (error) {
          onError?.call(error.toString());
        },
        onDone: () {
          isRunning = false;
          onDone?.call();
        },
      );

      if (await record!.hasPermission()) {
        // 3. 开始录音
        final stream = await record!.startStream(
          RecordConfig(
            encoder: AudioEncoder.pcm16bits,
            sampleRate: 16000,
            numChannels: 1,
          ),
        );

        // 4. 发送音频数据（每100ms发送3200字节）
        audioSubscription = stream.listen((Uint8List pcmData) {
          if (channel?.closeCode == null) {
            // 分包发送（腾讯云要求每包约100ms音频）
            for (var i = 0; i < pcmData.length; i += 3200) {
              final end = i + 3200;
              final chunk = end < pcmData.length
                  ? pcmData.sublist(i, end)
                  : pcmData.sublist(i);

              channel?.sink.add(chunk);
            }
          }
        });
      }
    } catch (e) {
      isRunning = false;
      onError?.call(e.toString());
    }
  }

  Future<void> stop() async {
    if (!isRunning) {
      return;
    }

    // 1. 停止音频订阅
    await audioSubscription?.cancel();
    audioSubscription = null;

    // 2. 停止录音
    if (await record!.isRecording()) {
      await record!.stop();
    }

    // 3. 停止 WebSocket 订阅
    await wsSubscription?.cancel();
    wsSubscription = null;

    // 发送结束标记（空数据帧）
    if (channel?.closeCode == null) {
      channel?.sink.add(Uint8List(0)); // 发送结束标记
      await Future.delayed(Duration(milliseconds: 500)); // 等待最终结果
      channel?.sink.close();
    }

    channel = null;

    isRunning = false;
  }

  // 销毁时释放资源
  Future<void> dispose() async {
    await stop();
    // 注意：不要关闭全局的_recordInstance，其他实例可能在使用
  }
}
