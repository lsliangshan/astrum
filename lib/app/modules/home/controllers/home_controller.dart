import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/types/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<TabName> currentTabName = TabName.home.obs;

  late TabController tabController;

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
  }

  void changeTab(TabName tabName) {
    currentTabName.value = tabName;
    update(['update-selected-tab']);
  }
}
