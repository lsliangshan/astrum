import 'dart:io';

import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/components/custom_backward_view/custom_backward_view.dart';
import 'package:astrum/components/custom_loader/custom_loader.dart';
import 'package:astrum/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/member_controller.dart';

class MemberView extends GetView<MemberController> {
  const MemberView({super.key});

  Widget renderPrivilegeItem(Map<String, String> privilege) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
      child: ListTile(
        isThreeLine: true,
        leading: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFF282828),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          child: SvgPicture.asset(
            privilege['icon']!,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        horizontalTitleGap: 8,
        title: Text(
          privilege['title']!.tr,
          style: Get.theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          privilege['tip']!.tr,
          // .replaceAll(
          //   '{GIFT_REGISTER_LIMIT}',
          //   FreeGiftRegisterLimit.toString(),
          // )
          // .replaceAll(
          //   '{IMPORT_CONTACTS_LIMIT}',
          //   FreeImportContactsLimit.toString(),
          // )
          // .replaceAll(
          //   '{FREE_EVENT_REMINDER_LIMIT}',
          //   FreeEventReminderLimit.toString(),
          // ),
          style: Get.theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'member.card.title'.tr,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF282828),
        leading: const CustomBackwardView(color: Colors.white),
        actions: [
          // TextButton(
          //   onPressed: () {
          //     controller.gotoPurchaseRecord();
          //   },
          //   child: Text(
          //     'member.btn.buy.record'.tr,
          //     style: const TextStyle(
          //       fontSize: 14,
          //       color: Colors.white54,
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   width: 12,
          // ),
        ],
      ),
      body: FutureBuilder(
        future: controller.initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CustomLoader());
          }
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: (Get.width - 48) / (1011 / 638) * 0.8 + 32 + 24,
                      color: const Color(0xFF282828),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: Get.width,
                              height:
                                  (Get.width - 48) / (1011 / 638) * 0.8 + 32,
                              color: const Color(0xFF282828),
                              alignment: Alignment.center,
                              child: Card(
                                margin: const EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  width: Get.width - 48,
                                  height: (Get.width - 48) / (1011 / 638) * 0.8,
                                  color: Colors.black,
                                  child: Stack(
                                    children: [
                                      GetBuilder(
                                        id: 'update-login-info',
                                        init: controller,
                                        builder: (_) {
                                          return Container(
                                            width: Get.width - 48,
                                            height:
                                                (Get.width - 48) /
                                                (1011 / 638) *
                                                0.8,
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                              'assets/svgs/member_card_5.svg',
                                              fit: BoxFit.fill,
                                              width: Get.width - 48,
                                              colorFilter:
                                                  controller
                                                          .user
                                                          .value
                                                          .vipType ==
                                                      'free'
                                                  ? const ColorFilter.mode(
                                                      Colors.white,
                                                      BlendMode.color,
                                                    )
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        right: 12,
                                        top: 12,
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Image.asset(
                                            'assets/images/icon.png',
                                            fit: BoxFit.cover,
                                            // color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      GetBuilder(
                                        id: 'update-login-info',
                                        init: controller,
                                        builder: (_) {
                                          return Positioned(
                                            left: 0,
                                            top: 32,
                                            child: SizedBox(
                                              width: Get.width,
                                              height: 72,
                                              child: ListTile(
                                                leading:
                                                    controller.isLogin.isTrue &&
                                                        controller
                                                                .user
                                                                .value
                                                                .avatar !=
                                                            null &&
                                                        controller
                                                            .user
                                                            .value
                                                            .avatar!
                                                            .isNotEmpty
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          // controller.previewImage(
                                                          //   image: controller
                                                          //       .loginInfo
                                                          //       .value!
                                                          //       .headIcon!,
                                                          //   tag:
                                                          //       'profile-head-icon',
                                                          // );
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white10,
                                                          radius: 24,
                                                          backgroundImage:
                                                              CachedNetworkImageProvider(
                                                                controller
                                                                    .user
                                                                    .value
                                                                    .avatar!,
                                                              ),
                                                        ),
                                                      )
                                                    : const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white10,
                                                        radius: 24,
                                                        child: Icon(
                                                          Icons.person,
                                                          color: Colors.white70,
                                                        ),
                                                      ),
                                                title: Text(
                                                  controller.renderName.value,
                                                  style: Get
                                                      .theme
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      GetBuilder(
                                        id: 'update-login-info',
                                        init: controller,
                                        builder: (_) {
                                          return Positioned(
                                            bottom: 12,
                                            left: 0,
                                            child: Container(
                                              width: Get.width - 48,
                                              height: 48,
                                              padding: const EdgeInsets.only(
                                                left: 24,
                                                right: 16,
                                              ),
                                              child: Row(
                                                children: [
                                                  if (controller
                                                              .user
                                                              .value
                                                              .vipType !=
                                                          'free' &&
                                                      controller
                                                              .user
                                                              .value
                                                              .vipEnd !=
                                                          null &&
                                                      controller
                                                          .user
                                                          .value
                                                          .vipEnd!
                                                          .isNotEmpty &&
                                                      DateTime.parse(
                                                        controller
                                                            .user
                                                            .value
                                                            .vipEnd!,
                                                      ).isAfter(DateTime.now()))
                                                    Text(
                                                      'member.status.active.date'
                                                          .tr
                                                          .replaceAll(
                                                            '{DATE}',
                                                            controller
                                                                    .user
                                                                    .value
                                                                    .vipEnd ??
                                                                '',
                                                          ),
                                                      style: Get
                                                          .theme
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            color: Colors
                                                                .orangeAccent,
                                                          ),
                                                    )
                                                  else
                                                    SizedBox(
                                                      width:
                                                          Get.width - 48 - 48,
                                                      child: Text(
                                                        'member.card.tip.subscription'
                                                            .tr,
                                                        style: Get
                                                            .theme
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                              color: Colors
                                                                  .orangeAccent,
                                                            ),
                                                      ),
                                                    ),
                                                  const Spacer(),
                                                  // FilledButton(
                                                  //   onPressed: () {},
                                                  //   style: FilledButton.styleFrom(
                                                  //     visualDensity:
                                                  //         VisualDensity.compact,
                                                  //     padding: const EdgeInsets
                                                  //         .symmetric(
                                                  //       horizontal: 16,
                                                  //     ),
                                                  //     backgroundColor:
                                                  //         Colors.orangeAccent,
                                                  //     foregroundColor: Colors.black,
                                                  //   ),
                                                  //   child:
                                                  //       Text('member.btn.buy'.tr),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: ListTile(
                        title: Text(
                          'member.privilege.title'.tr,
                          style: Get.theme.textTheme.titleMedium?.copyWith(
                            color: Get.theme.hintColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: GetBuilder(
                      id: 'update-language',
                      init: controller,
                      builder: (_) {
                        return Wrap(
                          children: memberPrivileges
                              .map((e) => renderPrivilegeItem(e))
                              .toList(),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: ListTile(
                        title: Text(
                          'member.privilege.service'.tr,
                          style: Get.theme.textTheme.titleMedium?.copyWith(
                            color: Get.theme.hintColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 12,
                      ),
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                controller.openUrl(
                                  url: ServiceAgreementUrl.replaceAll(
                                    '{LANG}',
                                    'language.short'.tr,
                                  ),
                                  title:
                                      'member.privilege.service.agreement'.tr,
                                );
                              },
                              leading: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF282828),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(6),
                                child: SvgPicture.asset(
                                  'assets/svgs/icon_service_agreement.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              title: Text(
                                'member.privilege.service.agreement'.tr,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Get.theme.disabledColor,
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Get.theme.disabledColor.withAlpha(15),
                              indent: 12,
                              endIndent: 12,
                            ),
                            ListTile(
                              onTap: () {
                                controller.openUrl(
                                  url: ServicePrivacyUrl.replaceAll(
                                    '{LANG}',
                                    'language.short'.tr,
                                  ),
                                  title: 'member.privilege.service.privacy'.tr,
                                );
                              },
                              leading: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF282828),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(6),
                                child: SvgPicture.asset(
                                  'assets/svgs/icon_privacy_policy.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              title: Text(
                                'member.privilege.service.privacy'.tr,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Get.theme.disabledColor,
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Get.theme.disabledColor.withAlpha(15),
                              indent: 12,
                              endIndent: 12,
                            ),
                            ListTile(
                              onTap: () {
                                controller.openUrl(
                                  url: ServiceTermsUrl.replaceAll(
                                    '{LANG}',
                                    'language.short'.tr,
                                  ),
                                  title: 'member.privilege.service.terms'.tr,
                                );
                              },
                              leading: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF282828),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(6),
                                child: SvgPicture.asset(
                                  'assets/svgs/icon_terms_of_service.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              title: Text('member.privilege.service.terms'.tr),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Get.theme.disabledColor,
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Get.theme.disabledColor.withAlpha(15),
                              indent: 12,
                              endIndent: 12,
                            ),
                            ListTile(
                              onTap: () {
                                controller.openUrl(
                                  url: ServiceAutoRenewalUrl.replaceAll(
                                    '{LANG}',
                                    'language.short'.tr,
                                  ),
                                  title:
                                      'member.privilege.auto.renewal.subscription.terms'
                                          .tr,
                                );
                              },
                              leading: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF282828),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(6),
                                child: SvgPicture.asset(
                                  'assets/svgs/icon_auto_renewal.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              title: Text(
                                'member.privilege.auto.renewal.subscription.terms'
                                    .tr,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Get.theme.disabledColor,
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Get.theme.disabledColor.withAlpha(15),
                              indent: 12,
                              endIndent: 12,
                            ),
                            ListTile(
                              onTap: () {
                                controller.openUrl(
                                  url: ServiceFaqUrl.replaceAll(
                                    '{LANG}',
                                    'language.short'.tr,
                                  ),
                                  title: 'member.privilege.service.faq'.tr,
                                );
                              },
                              leading: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF282828),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(6),
                                child: SvgPicture.asset(
                                  'assets/svgs/icon_service_faq.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              title: Text('member.privilege.service.faq'.tr),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Get.theme.disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (Platform.isAndroid)
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.only(top: 12),
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            controller.gotoActivationCode();
                          },
                          child: Text('member.privilege.activation.code'.tr),
                        ),
                      ),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 320)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
