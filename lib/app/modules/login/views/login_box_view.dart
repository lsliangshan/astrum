import 'package:astrum/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginBoxView extends GetView<LoginController> {
  const LoginBoxView({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(left: 24, right: 24),
      elevation: 0,
      child: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            SizedBox(
              height: 64,
              child: Text(
                'login.login.title'.tr,
                style: Get.theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
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
                controller: controller.usernameController,
                focusNode: controller.usernameFocusNode,
                onTapOutside: (event) {
                  controller.usernameFocusNode.unfocus();
                },
                decoration: InputDecoration(
                  hintText: 'login.username.hint'.tr,
                  hintStyle: Get.theme.textTheme.titleMedium?.copyWith(
                    color: Get.theme.disabledColor,
                  ),
                  filled: true,
                  fillColor: Get.theme.disabledColor.withValues(alpha: 0.05),
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
                        'login.username'.tr,
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
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Get.theme.disabledColor.withValues(alpha: 0.1),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextFormField(
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  onTapOutside: (event) {
                    controller.passwordFocusNode.unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: 'login.password.hint'.tr,
                    hintStyle: Get.theme.textTheme.titleMedium?.copyWith(
                      color: Get.theme.disabledColor,
                    ),
                    filled: true,
                    fillColor: Get.theme.disabledColor.withValues(alpha: 0.05),
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
                          'login.password'.tr,
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.changePasswordVisible();
                      },
                      icon: controller.isPasswordVisible.isTrue
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  obscureText: controller.isPasswordVisible.isFalse,
                ),
              ),
            ),
            Container(
              height: 48,
              margin: EdgeInsets.only(top: 24),
              width: Get.width,
              child: FilledButton(
                onPressed: () {
                  controller.login();
                },
                child: Text('login.login.btn'.tr),
              ),
            ),

            Container(
              height: 48,
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  controller.gotoRegister();
                },
                style: TextButton.styleFrom(overlayColor: Colors.transparent),
                child: Text(
                  'login.no_account'.tr,
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
