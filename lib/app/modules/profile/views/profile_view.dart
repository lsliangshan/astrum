import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile.title'.tr, style: Get.theme.textTheme.titleMedium),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Obx(
              () => ListTile(
                title: Text(
                  controller.isLogin.isTrue
                      ? controller.user.value.username
                      : 'profile.anonymous'.tr,
                ),
              ),
            ),
            Obx(() {
              if (controller.isLogin.isTrue) {
                return TextButton(
                  onPressed: () {
                    controller.logout();
                  },
                  style: TextButton.styleFrom(
                    overlayColor: Get.theme.colorScheme.error.withValues(
                      alpha: 0.5,
                    ),
                  ),
                  child: Text(
                    'profile.logout'.tr,
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: Get.theme.colorScheme.error,
                    ),
                  ),
                );
              }
              return TextButton(
                onPressed: () {
                  controller.gotoLogin();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Get.theme.colorScheme.secondary,
                ),
                child: Text(
                  'profile.login'.tr,
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
