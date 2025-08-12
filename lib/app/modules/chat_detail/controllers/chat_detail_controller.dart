import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChatDetailController extends GetxController {
  final String roleId;
  final String roleName;

  ChatDetailController({required this.roleId, required this.roleName});

  AuthService authService = Get.find<AuthService>();
  final MessageService messageService = Get.find<MessageService>();
  // final EventBus eventBus = Get.find<EventBus>();
  // final UserService userService = Get.find<UserService>();
  // final DingtalkService dingtalkService = Get.find<DingtalkService>();

  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 0,
  );

  final TextEditingController messageController = TextEditingController();

  final FocusNode messageFocusNode = FocusNode();

  Rx<int> newMessageCount = 0.obs;

  String prevText = '';

  Rx<User> get loginInfo => authService.user;
  RxBool get isLogin => authService.isLogin;

  Rx<bool> isLoadingMoreMessages = false.obs;

  RxList<Message> messages = <Message>[].obs;

  Rx<int> pageIndex = 1.obs;
  Rx<int> pageSize = 10.obs;
  Rx<int> totalCount = 0.obs;
  Rx<int> totalPage = 0.obs;

  late Future<void> initDataFuture;

  @override
  void onInit() {
    super.onInit();

    prevText = messageController.text;

    initDataFuture = initData();

    messageController.addListener(messageListener);

    messageService.onMessageEvent(
      roleId: roleId,
      callback: (message) {
        // 移除发送中的消息
        // messages.removeWhere(
        //   (Message msg) => msg.status == 'sending' && msg.id == message.id,
        // );

        int messageIndex = messages.indexWhere(
          (Message msg) => msg.status == 'sending' && msg.id == message.id,
        );

        if (messageIndex != -1) {
          messages[messageIndex] = message;
          // messages.removeAt(messageIndex);
          // messages.insert(messageIndex, message);
        } else {
          messages.insert(0, message);
        }
        newMessageCount.value += 1;
        update(['update-messages']);
      },
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreMessages();
      }
      if (scrollController.position.pixels <
          scrollController.position.minScrollExtent + 60) {
        newMessageCount.value = 0;
      }
    });
  }

  @override
  void onClose() {
    messageService.offMessageEvent(roleId: roleId);
    super.onClose();
  }

  void messageListener() {
    final curr = messageController.text;
    prevText = curr;
  }

  Future<void> getMessages({int? pIndex}) async {
    NormalResponse response = await messageService.getMessages(
      roleId: roleId,
      pageIndex: pIndex ?? pageIndex.value,
      pageSize: pageSize.value,
    );

    // await Future.delayed(const Duration(milliseconds: 800));

    if (response.code == 200 && response.data != null) {
      if (pIndex == 1) {
        messages.clear();
      }
      messages.addAll(response.data['list'].reversed.toList());
      pageIndex.value = pIndex ?? pageIndex.value;
      totalCount.value = response.data['totalCount'];
      totalPage.value = response.data['totalPage'];
    }
    isLoadingMoreMessages.value = false;
    update(['update-messages']);
  }

  Future<void> loadMoreMessages() async {
    if (pageIndex.value >= totalPage.value || isLoadingMoreMessages.value) {
      return;
    }
    isLoadingMoreMessages.value = true;
    update(['update-messages']);
    await getMessages(pIndex: pageIndex.value + 1);
  }

  Future<void> initData() async {
    await getMessages();
  }

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }

    messageFocusNode.unfocus();

    Message newMessage = Message(
      id: Uuid().v4(),
      roleId: roleId,
      content: messageController.text,
      senderId: loginInfo.value.id,
      senderName: loginInfo.value.username,
      senderAvatar: loginInfo.value.avatar ?? '',
      type: 'text',
      isRobot: false,
      createAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      status: 'success',
    );
    messages.insert(0, newMessage);

    Message robotMessage = Message(
      id: 'robot-response-${newMessage.id}',
      roleId: newMessage.roleId,
      content: '',
      senderId: newMessage.roleId,
      senderName: 'astrum',
      senderAvatar: 'https://img.liangqy.com/astrum/astrum.png',
      type: 'text',
      isRobot: true,
      createAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      status: 'sending',
    );
    messages.insert(0, robotMessage);

    await messageService.sendMessage(
      id: newMessage.id,
      roleId: newMessage.roleId,
      content: newMessage.content,
      senderId: newMessage.senderId!,
      senderName: newMessage.senderName!,
      senderAvatar: newMessage.senderAvatar,
      type: newMessage.type,
      isRobot: newMessage.isRobot,
      status: newMessage.status,
    );

    update(['update-messages']);
    messageController.clear();
    scrollToBottom();
  }

  void scrollToBottom({bool useAnimation = true}) {
    if (useAnimation) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  void scrollToNewMessage() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    newMessageCount.value = 0;
  }

  Future<void> gotoLogin() async {
    await Get.toNamed(Routes.LOGIN);
    messages.clear();
    pageIndex.value = 1;
    totalCount.value = 0;
    totalPage.value = 0;
    isLoadingMoreMessages.value = false;
    await initData();
  }
}
