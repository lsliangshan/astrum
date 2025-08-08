import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/app/modules/role/controllers/role_controller.dart';
import 'package:astrum/types/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<TabName> currentTabName = TabName.role.obs;

  late TabController tabController;

  RxList<String> initialedView = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(
      initialIndex: tabs.indexWhere(
        (item) => item['name'] == currentTabName.value,
      ),
      length: tabs.length,
      vsync: this,
    );

    tabController.addListener(() {
      currentTabName.value = tabs[tabController.index]['name'];
    });

    initViewController();
  }

  void changeTab(TabName tabName) {
    currentTabName.value = tabName;
    initViewController();
    update(['update-selected-tab']);
  }

  void initViewController() {
    if (!initialedView.contains("RoleView")) {
      initialedView.add('RoleView');
      Get.put<RoleController>(RoleController());
    }
  }
}
