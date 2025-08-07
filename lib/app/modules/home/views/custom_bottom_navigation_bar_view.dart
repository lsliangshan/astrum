import 'dart:ui';

import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class CustomBottomNavigationBarView extends GetView<HomeController> {
  const CustomBottomNavigationBarView({super.key});

  Widget renderTabBarItem(Map<String, dynamic> item) {
    return Tab(
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => SvgPicture.asset(
                controller.currentTabName.value == item['name']
                    ? item['icon_selected']
                    : item['icon'],
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  Get.theme.hintColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 6),
            Text('${item['label']}'.tr),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 64,
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 24),
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        elevation: 2,
        shadowColor: Colors.white.withAlpha(10),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6), // 设置模糊程度
                child: Container(
                  color: Colors.black.withAlpha(20), // 透明背景
                ),
              ),
            ),
            Container(
              height: 64,
              width: Get.width,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
              ),
              child: SizedBox(
                height: 40,
                child: TabBar(
                  controller: controller.tabController,
                  indicatorWeight: 0,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Get.theme.colorScheme.onPrimary,
                  labelPadding: EdgeInsets.only(left: 0, right: 0),
                  labelStyle: Get.textTheme.titleSmall?.copyWith(
                    color: Get.theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: Get.textTheme.titleSmall?.copyWith(
                    color: Get.theme.hintColor,
                    fontWeight: FontWeight.normal,
                  ),
                  tabs: tabs.map((item) => renderTabBarItem(item)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
