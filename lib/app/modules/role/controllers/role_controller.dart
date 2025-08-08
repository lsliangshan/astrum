import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/services/role.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  RoleService roleService = Get.find<RoleService>();

  RxInt pageIndex = 1.obs;
  RxInt pageSize = 20.obs;
  RxInt totalCount = 0.obs;
  RxInt totalPage = 1.obs;

  RxList<Role> roles = <Role>[].obs;

  late Future<void> initRoleFuture;

  @override
  void onInit() {
    super.onInit();

    initRoleFuture = initData();
  }

  Future<void> initData() async {
    final response = await roleService.getRoles(
      pageIndex: pageIndex.value,
      pageSize: pageSize.value,
    );

    if (response.code == 200 && response.data != null) {
      if (pageIndex.value == 1) {
        roles.clear();
      }
      if (response.data['list'] != null && response.data['list'].isNotEmpty) {
        roles.addAll(response.data['list'].map<Role>((e) => Role.fromJson(e)));
      }

      totalCount.value = response.data['totalCount'];
      totalPage.value = response.data['totalPage'];

      update(['update-roles']);
    }
  }

  Future<void> onRefresh() async {
    pageIndex.value = 1;
    await initData();
  }

  void gotoAddRole() {
    Get.toNamed(Routes.ADD_ROLE);
  }
}
