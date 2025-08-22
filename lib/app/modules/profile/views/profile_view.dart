import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
                      height: 120,
                      padding: EdgeInsets.only(left: 24),
                      child: Row(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (controller.isLogin.isTrue &&
                              controller.user.value.avatar != null &&
                              controller.user.value.avatar!.isNotEmpty)
                            Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Get.theme.hintColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    controller.user.value.avatar!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
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
                                trailing: UnconstrainedBox(
                                  child: SizedBox(
                                    width: 64,
                                    height: 34,
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
                                                  .onPrimary,
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
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 24, right: 24, top: 24),
                        shadowColor: Get.theme.colorScheme.onSurface,
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                spacing: 8,
                                children: [
                                  Text('profile.member_card.title'.tr),
                                  if (controller.user.value.vipType != 'free')
                                    SvgPicture.asset(
                                      'assets/svgs/icon_vip.svg',
                                      height: 32,
                                    ),
                                ],
                              ),
                              contentPadding: EdgeInsets.only(
                                left: 12,
                                right: 12,
                              ),
                              // trailing: SvgPicture.asset(
                              //   'assets/svgs/icon_vip.svg',

                              //   height: 32,
                              // ),
                              // trailing: UnconstrainedBox(
                              //   child: SizedBox(
                              //     width: 64,
                              //     height: 34,
                              //     child: TextButton(
                              //       onPressed: () {
                              //         controller.gotoLogin();
                              //       },
                              //       style: TextButton.styleFrom(
                              //         backgroundColor: Get.theme.primaryColor,
                              //       ),
                              //       child: Text(
                              //         'profile.member_card.btn.recharge'.tr,
                              //         style: Get.theme.textTheme.bodyMedium
                              //             ?.copyWith(
                              //               color:
                              //                   Get.theme.colorScheme.onPrimary,
                              //             ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                            Container(
                              height: 1,
                              color: Get.theme.dividerColor.withValues(
                                alpha: 0.05,
                              ),
                            ),
                            Obx(() {
                              if (controller.user.value.vipType == 'free') {
                                return ListTile(
                                  title: Text(
                                    'profile.member_card.remaining_tokens'.tr,
                                    style: Get.theme.textTheme.bodyMedium
                                        ?.copyWith(
                                          color: Get.theme.disabledColor,
                                        ),
                                  ),
                                  trailing: Text(
                                    NumberFormat(
                                      '#,###',
                                    ).format(controller.user.value.tokens),
                                    style: Get.theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.green),
                                  ),
                                );
                              }
                              return ListTile(
                                title: Text(
                                  'profile.member_card.vip_end'.tr,
                                  style: Get.theme.textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Get.theme.disabledColor,
                                      ),
                                ),
                                trailing: Text(
                                  controller.user.value.vipEnd ?? '',
                                  style: Get.theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.green),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  }),
                  Obx(() {
                    if (controller.isLogin.isTrue) {
                      return Container(
                        width: Get.width,
                        margin: EdgeInsets.only(left: 24, right: 24, top: 32),
                        decoration: BoxDecoration(
                          color: Get.theme.dividerColor.withValues(alpha: 0.02),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          onTap: () {
                            controller.gotoActivationCode();
                          },
                          title: Text('profile.settings.exchange'.tr),
                          trailing: SvgPicture.asset(
                            'assets/svgs/icon_arrow_right.svg',
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              Get.theme.colorScheme.onSurface.withValues(
                                alpha: 0.4,
                              ),
                              BlendMode.srcIn,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(left: 16, right: 16),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  }),
                  SizedBox(height: 24),
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
                    return SizedBox.shrink();
                  }),

                  // TextButton(
                  //   onPressed: () {
                  //     controller.test();
                  //   },
                  //   child: Text('profile.test'.tr),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     controller.testEnd();
                  //   },
                  //   child: Text('profile.stop'.tr),
                  // ),

                  // Obx(() {
                  //   return Container(
                  //     width: Get.width,
                  //     height: 500,
                  //     child: Text(controller.asrResult.join('，')),
                  //   );
                  // }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
