import 'package:get/get.dart';

import '../modules/add_attachment/bindings/add_attachment_binding.dart';
import '../modules/add_attachment/views/add_attachment_view.dart';
import '../modules/add_role/bindings/add_role_binding.dart';
import '../modules/add_role/views/add_role_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/discovery/bindings/discovery_binding.dart';
import '../modules/discovery/views/discovery_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/role/bindings/role_binding.dart';
import '../modules/role/views/role_view.dart';

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
      page: () => const AddRoleView(),
      binding: AddRoleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ATTACHMENT,
      page: () => const AddAttachmentView(),
      binding: AddAttachmentBinding(),
    ),
  ];
}
