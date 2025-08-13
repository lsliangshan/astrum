import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('profile.title'.tr, style: Get.theme.textTheme.titleMedium),
      //   centerTitle: true,
      // ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SvgPicture.asset(
              'assets/svgs/profile_bg.svg',
              width: Get.width - 100,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            top: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Obx(() {
                    return Container(
                      width: Get.width,
                      height: 180,
                      padding: EdgeInsets.only(left: 24),
                      child: Row(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (controller.isLogin.isTrue &&
                              controller.user.value.avatar != null)
                            Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Get.theme.colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: controller.user.value.avatar!,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/default_avatar.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          if (controller.isLogin.isTrue)
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  controller.user.value.nickname ??
                                      controller.user.value.username,
                                  style: Get.theme.textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'ID: ${controller.user.value.id}',
                                  style: Get.theme.textTheme.bodySmall
                                      ?.copyWith(
                                        color: Get.theme.disabledColor,
                                      ),
                                ),
                              ),
                            )
                          else
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'profile.anonymous'.tr,
                                  style: Get.theme.textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                subtitle: UnconstrainedBox(
                                  child: SizedBox(
                                    width: 80,
                                    child: TextButton(
                                      onPressed: () {
                                        controller.gotoLogin();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            Get.theme.colorScheme.secondary,
                                      ),
                                      child: Text(
                                        'profile.login'.tr,
                                        style: Get.theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: Get
                                                  .theme
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
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
          ),
        ],
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       Obx(
      //         () => ListTile(
      //           title: Text(
      //             controller.isLogin.isTrue
      //                 ? controller.user.value.username
      //                 : 'profile.anonymous'.tr,
      //           ),
      //         ),
      //       ),
      //       Obx(() {
      //         if (controller.isLogin.isTrue) {
      //           return TextButton(
      //             onPressed: () {
      //               controller.logout();
      //             },
      //             style: TextButton.styleFrom(
      //               overlayColor: Get.theme.colorScheme.error.withValues(
      //                 alpha: 0.5,
      //               ),
      //             ),
      //             child: Text(
      //               'profile.logout'.tr,
      //               style: Get.theme.textTheme.bodyMedium?.copyWith(
      //                 color: Get.theme.colorScheme.error,
      //               ),
      //             ),
      //           );
      //         }
      //         return TextButton(
      //           onPressed: () {
      //             controller.gotoLogin();
      //           },
      //           style: TextButton.styleFrom(
      //             backgroundColor: Get.theme.colorScheme.secondary,
      //           ),
      //           child: Text(
      //             'profile.login'.tr,
      //             style: Get.theme.textTheme.bodyMedium?.copyWith(
      //               color: Get.theme.colorScheme.onSurface,
      //             ),
      //           ),
      //         );
      //       }),
      //     ],
      //   ),
      // ),
    );
  }
}
