import 'dart:ui';

import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class CustomBottomNavigationBarView extends GetView<HomeController> {
  const CustomBottomNavigationBarView({super.key});

  Widget renderTabItem(Map<String, dynamic> item) {
    // return GetBuilder(
    //   tag: 'update-selected-tab',
    //   init: controller,
    //   builder: (_) {

    //   },
    // );
    if (item['name'] == controller.currentTabName.value) {
      return Container(
        height: 40,
        padding: EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              item['icon_selected'],
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Get.theme.colorScheme.onPrimary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${item['label']}'.tr,
              style: Get.textTheme.titleMedium?.copyWith(
                color: Get.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        controller.changeTab(item['name']);
        print('>>>>>>>>>>> changeTab: ${item["name"]}');
      },
      child: Container(
        height: 48,
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              item['icon'],
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                Get.theme.hintColor,
                BlendMode.srcIn,
              ),
            ),
            Opacity(
              opacity: 0,
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  Text(
                    '${item['label']}'.tr,
                    style: Get.textTheme.titleMedium?.copyWith(
                      color: Get.theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
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
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6), // 设置模糊程度
              child: Container(
                color: Colors.white.withAlpha(20), // 透明背景
              ),
            ),
          ),
          Container(
            height: 64,
            width: Get.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tabs
                  .map((item) => Obx(() => renderTabItem(item)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
