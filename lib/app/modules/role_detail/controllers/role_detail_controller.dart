import 'package:astrum/app/modules/add_role/views/add_role_view.dart';
import 'package:astrum/app/modules/attachments/views/attachments_view.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/services/role.dart';
import 'package:get/get.dart';

class RoleDetailController extends GetxController {
  String roleId;
  RoleDetailController({required this.roleId});

  RoleService roleService = Get.find<RoleService>();

  Rx<Role> role = Role(id: '', name: '').obs;

  late Future<void> initRoleDetailFuture;

  @override
  void onInit() {
    super.onInit();

    initRoleDetailFuture = initData();
  }

  Future<void> initData() async {
    final response = await roleService.getRoleDetail(roleId: roleId);

    if (response.code == 200 && response.data != null) {
      role.value = Role.fromJson(response.data);
    }

    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> gotoEditRole() async {
    await Get.to(() => AddRoleView(roleId: roleId));

    await initData();
  }

  Future<void> gotoAttachments() async {
    await Get.to(
      () => AttachmentsView(roleId: roleId, roleName: role.value.name),
    );
  }
}
