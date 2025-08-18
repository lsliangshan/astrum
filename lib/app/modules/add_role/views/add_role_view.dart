import 'dart:io';

import 'package:astrum/components/custom_backward_view/custom_backward_view.dart';
import 'package:astrum/components/custom_loader/custom_loader.dart';
import 'package:astrum/components/need_login/need_login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/add_role_controller.dart';

// ignore: must_be_immutable
class AddRoleView extends GetView<AddRoleController> {
  String? roleId;
  AddRoleView({super.key, this.roleId}) {
    if (roleId != null && roleId!.isNotEmpty) {
      Get.put<AddRoleController>(
        AddRoleController(roleId: roleId!),
        tag: 'add-role-$roleId',
      );
    } else {
      if (!Get.isRegistered<AddRoleController>(tag: 'add-role')) {
        Get.put<AddRoleController>(AddRoleController(), tag: 'add-role');
      }
    }
  }

  @override
  AddRoleController get controller => (roleId != null && roleId!.isNotEmpty)
      ? Get.find(tag: 'add-role-$roleId')
      : Get.find(tag: 'add-role');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          roleId != null && roleId!.isNotEmpty
              ? 'edit_role.title'.tr
              : 'add_role.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: CustomBackwardView(),
      ),
      body: FutureBuilder(
        future: controller.initRoleDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CustomLoader());
          }

          if (controller.isLogin.isFalse) {
            return Center(child: NeedLogin(onPressed: controller.gotoLogin));
          }

          return SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                Card(
                  color: Colors.white,
                  elevation: 0,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      spacing: 12,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.theme.disabledColor.withValues(
                                alpha: 0.1,
                              ),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextFormField(
                            controller: controller.nameController,
                            focusNode: controller.nameFocusNode,
                            onTapOutside: (event) {
                              controller.nameFocusNode.unfocus();
                            },
                            decoration: InputDecoration(
                              hintText: 'add_role.name.hint'.tr,
                              hintStyle: Get.theme.textTheme.titleMedium
                                  ?.copyWith(color: Get.theme.disabledColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              label: Row(
                                children: [
                                  Text(
                                    'add_role.name'.tr,
                                    style: Get.theme.textTheme.bodyMedium,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '*',
                                    style: Get.theme.textTheme.labelLarge
                                        ?.copyWith(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.theme.disabledColor.withValues(
                                alpha: 0.1,
                              ),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextFormField(
                            controller: controller.descriptionController,
                            focusNode: controller.descriptionFocusNode,
                            onTapOutside: (value) {
                              controller.descriptionFocusNode.unfocus();
                            },
                            maxLines: 6,
                            minLines: 6,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline, // 允许换行
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              label: Text(
                                'add_role.description'.tr,
                                style: Get.theme.textTheme.bodyMedium,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'add_role.description.hint'.tr,
                              hintStyle: Get.theme.textTheme.titleMedium
                                  ?.copyWith(color: Get.theme.disabledColor),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text('add_role.icon'.tr),
                                  const SizedBox(width: 4),
                                  Text(
                                    '*',
                                    style: Get.theme.textTheme.labelLarge
                                        ?.copyWith(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Get.theme.disabledColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: EdgeInsets.all(12),
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.expand,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.selectRoleLogo();
                                        },
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                            'assets/svgs/icon_plus.svg',
                                            width: 48,
                                            height: 48,
                                            colorFilter: ColorFilter.mode(
                                              Get.theme.colorScheme.onSurface
                                                  .withValues(alpha: 0.18),
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => controller.roleIcon.value != null
                                            ? Positioned(
                                                child: IgnorePointer(
                                                  ignoring: true,
                                                  child: Container(
                                                    color: Colors.white,
                                                    width: 200,
                                                    height: 200,
                                                    alignment: Alignment.center,
                                                    child: IgnorePointer(
                                                      ignoring: true,
                                                      child: Image.file(
                                                        File(
                                                          controller
                                                              .roleIcon
                                                              .value!
                                                              .path,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : (controller.formData.value.icon !=
                                                      null &&
                                                  controller
                                                      .formData
                                                      .value
                                                      .icon!
                                                      .isNotEmpty)
                                            ? Positioned(
                                                child: IgnorePointer(
                                                  ignoring: true,
                                                  child: Container(
                                                    color: Colors.white,
                                                    width: 200,
                                                    height: 200,
                                                    alignment: Alignment.center,
                                                    child: IgnorePointer(
                                                      ignoring: true,
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .formData
                                                            .value
                                                            .icon!,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (
                                                              context,
                                                              url,
                                                            ) => const Center(
                                                              child:
                                                                  CustomLoader(),
                                                            ),
                                                        errorWidget:
                                                            (
                                                              context,
                                                              url,
                                                              error,
                                                            ) => const Icon(
                                                              Icons.error,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox.shrink(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 64,
                  margin: EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 8,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.goBack();
                        },
                        child: Text(
                          'btn.cancel'.tr,
                          style: Get.theme.textTheme.bodyMedium?.copyWith(
                            color: Get.theme.hintColor,
                          ),
                        ),
                      ),
                      Obx(
                        () => FilledButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  controller.saveRole();
                                },
                          child: controller.isLoading.value
                              ? CustomLoader(size: 10)
                              : Text(
                                  'btn.save'.tr,
                                  style: Get.theme.textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Get.theme.colorScheme.onPrimary,
                                      ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
