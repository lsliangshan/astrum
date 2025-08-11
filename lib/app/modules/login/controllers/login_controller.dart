import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/toast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  ToastService toastService = Get.find<ToastService>();
  AuthService authService = Get.find<AuthService>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  // true: 登录
  // false: 注册
  RxBool isLoginMode = true.obs;

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void resetPassword() {
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void gotoLogin() {
    isLoginMode.value = true;
    resetPassword();
    update();
  }

  void gotoRegister() {
    isLoginMode.value = false;
    resetPassword();
    update();
  }

  void changePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
    update(['update-password-visible']);
  }

  void changeConfirmPasswordVisible() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
    update(['update-confirm-password-visible']);
  }

  Future<void> login() async {
    if (usernameController.text.isEmpty) {
      toastService.showError('login.valid.username.can_not_empty'.tr);
      usernameFocusNode.requestFocus();
      return;
    }
    if (passwordController.text.isEmpty) {
      toastService.showError('login.valid.password.can_not_empty'.tr);
      passwordFocusNode.requestFocus();
      return;
    }

    NormalResponse response = await authService.login(
      username: usernameController.text,
      password: passwordController.text,
    );
    if (response.code == 200) {
      // 登录成功
      Get.back();
      toastService.showSuccess('login.login.success'.tr);
    } else {
      String errorCode = 'unknown';
      if (response.code == 1001) {
        // 用户名不存在
        errorCode = 'username_not_exist';
      } else if (response.code == 1002) {
        // 密码错误
        errorCode = 'password_error';
      }
      // 登录失败
      toastService.showError('login.login.error.$errorCode'.tr);
    }
  }

  Future<void> register() async {
    if (usernameController.text.isEmpty) {
      toastService.showError('login.valid.username.can_not_empty'.tr);
      usernameFocusNode.requestFocus();
      return;
    }
    if (passwordController.text.isEmpty) {
      toastService.showError('login.valid.password.can_not_empty'.tr);
      passwordFocusNode.requestFocus();
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      toastService.showError('login.valid.confirm_password.can_not_empty'.tr);
      confirmPasswordFocusNode.requestFocus();
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      toastService.showError('login.valid.confirm_password.not_match'.tr);
      confirmPasswordFocusNode.requestFocus();
      return;
    }

    NormalResponse response = await authService.register(
      username: usernameController.text,
      password: passwordController.text,
    );
    if (response.code == 200) {
      // 登录成功
      toastService.showSuccess('login.register.success'.tr);
      gotoLogin();
    } else {
      // 注册失败
      toastService.showError('login.register.error.unknown'.tr);
    }
  }
}
