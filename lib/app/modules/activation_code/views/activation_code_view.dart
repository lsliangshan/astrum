import 'package:astrum/components/custom_backward_view/custom_backward_view.dart';
import 'package:astrum/components/custom_loader/custom_loader.dart';
import 'package:astrum/input_formatter/activation_code_input_formatter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/activation_code_controller.dart';

class ActivationCodeView extends GetView<ActivationCodeController> {
  const ActivationCodeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'activation_code.title'.tr,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: const CustomBackwardView(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              height: 160,
              margin: const EdgeInsets.only(top: 48),
              // color: Colors.black,
              child: GetBuilder(
                id: 'update-login-info',
                init: controller,
                builder: (_) {
                  return Column(
                    children: [
                      if (controller.isLogin.isTrue &&
                          controller.user.value.avatar != null &&
                          controller.user.value.avatar!.isNotEmpty)
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundColor: Get.theme.primaryColor,
                            radius: 40,
                            backgroundImage: CachedNetworkImageProvider(
                              controller.user.value.avatar!,
                            ),
                          ),
                        )
                      else
                        const CircleAvatar(
                          backgroundColor: Colors.black12,
                          radius: 24,
                          child: Icon(Icons.person, color: Colors.white70),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        controller.renderName.value,
                        style: Get.theme.textTheme.titleLarge,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'activation_code.hint'.tr,
                        hintStyle: const TextStyle(color: Color(0xFFB9B9C1)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      inputFormatters: [ActivationCodeInputFormatter()],
                      style: const TextStyle(
                        color: Color(0xFF022E57),
                        fontWeight: FontWeight.w600,
                      ),
                      controller: controller.activationCodeController,
                      focusNode: controller.activationCodeFocusNode,
                      onTapOutside: (value) {
                        controller.activationCodeFocusNode.unfocus();
                      },
                    ),
                    const SizedBox(height: 16),
                    GetBuilder(
                      id: 'update-activation-code',
                      init: controller,
                      builder: (_) {
                        return SizedBox(
                          width: Get.width,
                          height: 48,
                          child: FilledButton(
                            onPressed:
                                controller
                                        .activationCodeController
                                        .text
                                        .isNotEmpty &&
                                    controller.isExchanging.isFalse
                                ? () {
                                    controller.exchangeActivationCode();
                                  }
                                : null,
                            child: controller.isExchanging.isTrue
                                ? CustomLoader(
                                    size: 12,
                                    color: Get.theme.disabledColor,
                                  )
                                : Text('activation_code.btn.exchange'.tr),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text(
                'activation_code.rule.title'.tr,
                style: Get.theme.textTheme.titleMedium?.copyWith(
                  color: Get.theme.hintColor,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'activation_code.rule.tip1'.tr,
                style: Get.theme.textTheme.titleSmall?.copyWith(
                  color: Get.theme.disabledColor,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'activation_code.rule.tip2'.tr,
                style: Get.theme.textTheme.titleSmall?.copyWith(
                  color: Get.theme.disabledColor,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
