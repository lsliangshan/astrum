import 'dart:async';
import 'dart:convert';

import 'package:astrum/database/daos/message.dao.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:flutter_http_sse/client/sse_client.dart';
import 'package:flutter_http_sse/model/sse_request.dart';
import 'package:flutter_http_sse/model/sse_response.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MessageService extends GetxService {
  MessageDao messageDao = Get.find<MessageDao>();

  RxMap<String, Function(Message)> messageEventCallbacks =
      <String, Function(Message)>{}.obs;

  int maxRetries = 3;
  int attempt = 0;
  Duration delay = const Duration(seconds: 1);

  Stream<SSEResponse> stream = Stream.empty();

  @override
  void onClose() {
    super.onClose();
    destroyMessageService();
  }

  Future<NormalResponse> getMessages({
    required String roleId,
    int? pageIndex = 1,
    int? pageSize = 20,
  }) async {
    return await messageDao.getMessages(
      pageIndex: pageIndex,
      pageSize: pageSize,
      roleId: roleId,
    );
  }

  // void connect({
  //   required String url,
  //   required Map<String, String> headers,
  //   SSERequestType method = SSERequestType.GET,
  //   Map<String, dynamic>? body,
  //   required void Function(SSEModel) onEvent,
  // }) {
  //   attempt++;
  //   subscription = SSEClient.subscribeToSSE(
  //     method: method,
  //     url: url,
  //     header: headers,
  //     body: body,
  //   ).listen(onEvent, onError: (e, st) async {
  //     if (attempt >= maxRetries) {
  //       print('>>>>> 超过重连次数: ${maxRetries}');
  //       await subscription?.cancel();
  //       SSEClient.unsubscribeFromSSE();
  //     } else {
  //       await Future.delayed(delay);
  //       connect(
  //         // 递归重连
  //         url: url,
  //         headers: headers,
  //         method: method,
  //         body: body,
  //         onEvent: onEvent,
  //       );
  //     }
  //   });
  // }

  Future<void> sendMessageToRobot({
    required String messageId,
    required String roleId,
    required String content,
    required String userId,
  }) async {
    await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/astrum/send-message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'roleId': roleId,
        'content': content,
        'userId': userId,
        "messageId": messageId,
      }),
    );
  }

  Future<void> sendMessage({
    required String id,
    required String roleId,
    required String content,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    String? type,
    bool? isRobot,
    String? status,
  }) async {
    await messageDao.createMessage(
      id: id,
      roleId: roleId,
      content: content,
      senderId: senderId,
      senderName: senderName,
      senderAvatar: senderAvatar,
      type: type,
      isRobot: isRobot,
      status: status,
    );

    if (isRobot != null && isRobot == false) {
      // 人工发送的消息
      sendMessageToRobot(
        roleId: roleId,
        content: content,
        userId: senderId,
        messageId: id,
      );
      // 发送一条机器人回复的消息，显示发送中状态
      await messageDao.createMessage(
        id: 'robot-response-$id',
        roleId: roleId,
        content: '',
        senderId: roleId,
        senderName: 'astrum',
        senderAvatar: 'https://img.liangqy.com/astrum/astrum.png',
        type: 'text',
        isRobot: true,
        status: 'sending',
      );
    }
  }

  void destroyMessageService() {
    stream.drain();
  }

  Future<void> initMessageService({required String userId}) async {
    if (userId.isEmpty) {
      return;
    }

    final request = SSERequest(
      url: "http://api.liangqy.com/on/all/astrum/robot/message/$userId",
      headers: {"Cache-Control": "no-cache"},
      onData: (data) {},
      onError: (error) {
        // print(">>>>>>> Error: $error");
      },
      onDone: () {
        // print(">>>>>>> Stream closed");
      },
      retry: true, // Enables automatic reconnection
    );

    final sseClient = SSEClient();
    stream = sseClient.connect("connectionId", request);

    stream.listen(
      (SSEResponse response) {
        if (response.data != null && response.data!.isNotEmpty) {
          Message data = Message.fromJson(response.data!);

          messageEventCallbacks[data.roleId]?.call(data);

          // 更新消息内容
          messageDao.updateMessage(
            id: data.id,
            content: data.content,
            status: data.status ?? 'success',
          );

          // sendMessage(
          //   id: data.id,
          //   roleId: data.roleId,
          //   content: data.content,
          //   senderId: data.senderId ?? '',
          //   senderName: data.senderName ?? '',
          //   senderAvatar: data.senderAvatar,
          //   type: data.type,
          //   isRobot: data.isRobot,
          //   status: data.status ?? 'success',
          // );
        }
      },
      onError: (error) {
        // print(">>>>>> SSE Error: $error");
      },
      onDone: () {
        // print(">>>>>>SSE Connection Closed");
      },
    );

    // connect(
    //   url: 'http://frp.liangqy.com/on/all/wing/robot/message',
    //   headers: {
    //     'Accept': 'text/event-stream',
    //     "Cache-Control": "no-cache",
    //   },
    //   onEvent: (event) {
    //     if (event.data != null && event.data!.isNotEmpty) {
    //       Message data = Message.fromJson(jsonDecode(event.data!));
    //       messageEventCallbacks[data.classId]?.call(data);
    //       sendMessage(
    //         id: data.id,
    //         classId: data.classId,
    //         content: data.content,
    //         senderId: data.senderId,
    //         senderName: data.senderName,
    //         senderAvatar: data.senderAvatar,
    //         type: data.type,
    //         isRobot: data.isRobot,
    //         from: data.from,
    //       );
    //     }
    //   },
    // );
  }

  onMessageEvent({
    required String roleId,
    required Function(Message) callback,
  }) {
    messageEventCallbacks[roleId] = callback;
  }

  offMessageEvent({required String roleId}) {
    messageEventCallbacks.remove(roleId);
  }
}
