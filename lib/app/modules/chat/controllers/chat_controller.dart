import 'package:astrum/app/modules/chat_detail/views/chat_detail_view.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/message.dart';
import 'package:astrum/services/role.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final MessageService messageService = Get.find<MessageService>();
  final RoleService roleService = Get.find<RoleService>();
  final AuthService authService = Get.find<AuthService>();

  RxList<Message> messages = <Message>[].obs;

  RxList<Role> roles = <Role>[].obs;

  Rx<User> get loginInfo => authService.user;

  RxInt pageIndex = 1.obs;
  RxInt pageSize = 10.obs;
  RxInt totalCount = 0.obs;
  RxInt totalPage = 1.obs;

  late Future<void> initChatsFuture;

  @override
  void onInit() {
    super.onInit();

    initChatsFuture = initData();
  }

  Future<void> initData() async {
    await initRoles();
  }

  Future<void> initRoles() async {
    final response = await roleService.getRolesFromLocal(
      authorId: loginInfo.value.id,
      pageIndex: pageIndex.value,
      pageSize: pageSize.value,
    );

    if (response.code == 200 && response.data != null) {
      if (pageIndex.value == 1) {
        roles.clear();
      }
      if (response.data['list'] != null && response.data['list'].isNotEmpty) {
        roles.addAll(response.data['list']);
      }

      totalCount.value = response.data['totalCount'];
      totalPage.value = response.data['totalPage'];

      update(['update-chats']);
    }
  }

  Future<void> onRefresh() async {
    pageIndex.value = 1;
    await initRoles();

    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> gotoChatDetail({required Role role}) async {
    await Get.to(() => ChatDetailView(roleId: role.id, roleName: role.name));
  }
}
