import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/app/modules/home/views/custom_bottom_navigation_bar_view.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ExtendedTabBarView(
        controller: controller.tabController,
        children: tabs.map((item) => item['page'] as Widget).toList(),
      ),
      bottomNavigationBar: CustomBottomNavigationBarView(),
    );
  }
}
