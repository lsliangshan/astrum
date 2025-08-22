import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivationCodeController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  ToastService toastService = Get.find<ToastService>();

  TextEditingController activationCodeController = TextEditingController(
    text: '',
  );
  FocusNode activationCodeFocusNode = FocusNode();

  Rx<User> get user => authService.user;
  RxBool get isLogin => authService.isLogin;

  Rx<bool> isExchanging = false.obs;

  Rx<String> get renderName {
    if (isLogin.isFalse) {
      return 'anonymous'.tr.obs;
    }
    if (user.value.nickname != null && user.value.nickname!.isNotEmpty) {
      return user.value.nickname!.obs;
    }

    return user.value.username.obs;
  }

  @override
  void onInit() {
    super.onInit();

    activationCodeController.addListener(() {
      update(['update-activation-code']);
    });
  }

  Future<void> exchangeActivationCode() async {
    if (activationCodeController.text.isEmpty) {
      return;
    }

    if (isExchanging.value) {
      return;
    }

    isExchanging.value = true;
    update(['update-activation-code']);

    NormalResponse normalResponse = await authService.exchangeActivationCode(
      code: activationCodeController.text,
    );

    if (normalResponse.code == 200) {
      Get.back(result: true);
      toastService.showSuccess('activation_code.btn.exchange.success'.tr);
    } else {
      toastService.showError(
        normalResponse.message ?? 'activation_code.btn.exchange.failed'.tr,
      );
      activationCodeController.clear();
    }

    isExchanging.value = false;
    update(['update-activation-code']);
  }
}
