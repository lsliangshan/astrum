import 'package:get/get.dart';

import '../modules/activation_code/bindings/activation_code_binding.dart';
import '../modules/activation_code/views/activation_code_view.dart';
import '../modules/add_attachment/bindings/add_attachment_binding.dart';
import '../modules/add_attachment/views/add_attachment_view.dart';
import '../modules/add_role/bindings/add_role_binding.dart';
import '../modules/add_role/views/add_role_view.dart';
import '../modules/attachments/bindings/attachments_binding.dart';
import '../modules/attachments/views/attachments_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chat_detail/bindings/chat_detail_binding.dart';
import '../modules/chat_detail/views/chat_detail_view.dart';
import '../modules/create_attachment/bindings/create_attachment_binding.dart';
import '../modules/create_attachment/views/create_attachment_view.dart';
import '../modules/discovery/bindings/discovery_binding.dart';
import '../modules/discovery/views/discovery_view.dart';
import '../modules/file_previewer/bindings/file_previewer_binding.dart';
import '../modules/file_previewer/views/file_previewer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/member/bindings/member_binding.dart';
import '../modules/member/views/member_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/role/bindings/role_binding.dart';
import '../modules/role/views/role_view.dart';
import '../modules/role_detail/bindings/role_detail_binding.dart';
import '../modules/role_detail/views/role_detail_view.dart';
import '../modules/webview/bindings/webview_binding.dart';
import '../modules/webview/views/webview_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DISCOVERY,
      page: () => const DiscoveryView(),
      binding: DiscoveryBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ROLE,
      page: () => const RoleView(),
      binding: RoleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ROLE,
      page: () => AddRoleView(),
      binding: AddRoleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ATTACHMENT,
      page: () => const AddAttachmentView(),
      binding: AddAttachmentBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_DETAIL,
      page: () => RoleDetailView(roleId: ''),
      binding: RoleDetailBinding(),
    ),
    GetPage(
      name: _Paths.ATTACHMENTS,
      page: () => AttachmentsView(roleId: '', roleName: ''),
      binding: AttachmentsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ATTACHMENT,
      page: () => CreateAttachmentView(roleId: '', roleName: ''),
      binding: CreateAttachmentBinding(),
    ),
    GetPage(
      name: _Paths.FILE_PREVIEWER,
      page: () => FilePreviewerView(
        fileUrl: Get.arguments['fileUrl'] ?? '',
        fileName: Get.arguments['fileName'] ?? '',
      ),
      binding: FilePreviewerBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_DETAIL,
      page: () => ChatDetailView(roleId: '', roleName: ''),
      binding: ChatDetailBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVATION_CODE,
      page: () => const ActivationCodeView(),
      binding: ActivationCodeBinding(),
    ),
    GetPage(
      name: _Paths.MEMBER,
      page: () => const MemberView(),
      binding: MemberBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEW,
      page: () => WebviewView(
        url: Get.arguments != null ? Get.arguments['url'] : null,
        title: Get.arguments != null ? Get.arguments['title'] : null,
      ),
      binding: WebviewBinding(),
    ),
  ];
}
