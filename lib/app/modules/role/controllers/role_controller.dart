import 'package:astrum/app/modules/role_detail/views/role_detail_view.dart';
import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/role.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  RoleService roleService = Get.find<RoleService>();
  AuthService authService = Get.find<AuthService>();

  RxInt pageIndex = 1.obs;
  RxInt pageSize = 20.obs;
  RxInt totalCount = 0.obs;
  RxInt totalPage = 1.obs;

  RxList<Role> roles = <Role>[].obs;

  Rx<User> get loginInfo => authService.user;
  RxBool get isLogin => authService.isLogin;

  late Future<void> initRoleFuture;

  @override
  void onInit() {
    super.onInit();

    initRoleFuture = initData();
  }

  Future<void> initData() async {
    await roleService.syncRoles(authorId: loginInfo.value.id);

    await getRolesFromLocal();
  }

  Future<void> getRolesFromLocal() async {
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
      update(['update-roles']);
    }
  }

  Future<void> onRefresh() async {
    pageIndex.value = 1;
    await initData();

    await Future.delayed(const Duration(milliseconds: 500));
  }

  void gotoAddRole() {
    Get.toNamed(Routes.ADD_ROLE);
  }

  void gotoRoleDetail(Role role) {
    // Get.to(() => AddRoleView(roleId: role.id));
    Get.to(() => RoleDetailView(roleId: role.id));
  }

  void gotoLogin() {
    Get.toNamed(Routes.LOGIN);
  }
}
