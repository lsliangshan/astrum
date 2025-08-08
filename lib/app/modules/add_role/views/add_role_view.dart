import 'dart:io';

import 'package:astrum/components/custom_backward_view/custom_backward_view.dart';
import 'package:astrum/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/add_role_controller.dart';

class AddRoleView extends GetView<AddRoleController> {
  const AddRoleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add_role.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: CustomBackwardView(),
      ),
      body: SingleChildScrollView(
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
                          color: Get.theme.disabledColor.withValues(alpha: 0.1),
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
                          hintStyle: Get.theme.textTheme.titleMedium?.copyWith(
                            color: Get.theme.disabledColor,
                          ),
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
                                style: Get.theme.textTheme.labelLarge?.copyWith(
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
                          color: Get.theme.disabledColor.withValues(alpha: 0.1),
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
                          hintStyle: Get.theme.textTheme.titleMedium?.copyWith(
                            color: Get.theme.disabledColor,
                          ),
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
                          child: Text('add_role.icon'.tr),
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
                              style: Get.theme.textTheme.bodyMedium?.copyWith(
                                color: Get.theme.colorScheme.onSurface,
                              ),
                            ),
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
}
