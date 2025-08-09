import 'package:get/get.dart';

import '../controllers/role_detail_controller.dart';

class RoleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleDetailController>(() => RoleDetailController(roleId: ''));
  }
}
