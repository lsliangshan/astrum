import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/localstorage.dart';
import 'package:astrum/services/tencent_asr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  LocalstorageService localstorageService = Get.find<LocalstorageService>();

  Rx<User> get user => authService.user;
  RxBool get isLogin => authService.isLogin;

  RxList<String> asrResult = <String>[].obs;

  TencentAsrService? asrService;

  Rx<String> currentLanguage = 'en_US'.obs;

  @override
  void onInit() {
    super.onInit();

    initLanguage();
  }

  void gotoLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  void logout() {
    authService.logout();
  }

  void gotoActivationCode() {
    Get.toNamed(Routes.ACTIVATION_CODE);
  }

  void gotoMember() {
    Get.toNamed(Routes.MEMBER);
  }

  Future<void> initLanguage() async {
    String localLanguage =
        (await localstorageService.getString(LocalLanguageKey)) ?? '';
    currentLanguage.value = (localLanguage != '')
        ? localLanguage
        : languages[0]['value']!;
  }

  void changeLanguage() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200, // 设置底部面板的高度
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ...languages.map(
                (language) => CheckboxListTile(
                  title: Text(language['label'] ?? ''),
                  subtitle: Text((language['name'] ?? '').tr),
                  value: currentLanguage.value == language['value'],
                  onChanged: (value) {
                    if (language['value'] != null) {
                      var locale = Locale(
                        language['value']!.split('_')[0],
                        language['value']!.split('_')[1],
                      );
                      Get.updateLocale(locale);
                      currentLanguage.value = language['value']!;
                      localstorageService.setString(
                        LocalLanguageKey,
                        language['value']!,
                      );
                      Get.back();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void gotoDeleteAccount() async {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'settings.delete.account.title'.tr,
          style: Get.theme.textTheme.titleLarge?.copyWith(
            color: Get.theme.colorScheme.error,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'settings.delete.account.tip'.tr,
          style: Get.theme.textTheme.bodyMedium?.copyWith(
            color: Get.theme.hintColor,
            // fontSize: 15,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'btn.cancel'.tr,
              style: TextStyle(color: Get.theme.disabledColor),
            ),
          ),
          FilledButton(
            onPressed: () {
              confirmDeleteAccount();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Get.theme.colorScheme.error,
            ),
            child: Text(
              'btn.delete'.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void confirmDeleteAccount() async {
    // NormalResponse response = await userService.deleteUser();
    // if (response.code == 200) {
    //   Get.back();
    //   initLoginInfo();
    //   toastService.showSuccess(
    //       message: 'settings.delete.account.success.title'.tr);
    // } else {
    //   toastService.showError(
    //       message: 'settings.delete.account.failed.title'.tr);
    // }
  }

  void test() {
    asrService = TencentAsrService();

    asrService!.start(
      onData: (data) {
        if (data != null) {
          if (data['slice_type'] == 0) {
            if (data['index'] == 0) {
              asrResult.clear();
            }
            asrResult.add('');
          } else if (data['slice_type'] == 1) {
            asrResult[data['index']] = data['voice_text_str'];
          } else if (data['slice_type'] == 2) {
            asrResult[data['index']] = data['voice_text_str'];
          }

          asrResult.refresh();
        }
      },
      onDone: () {
        print('>>>>>>>>>>>>>>>>>done');
      },
      onError: (error) {
        print('>>>>>>>>>>>>>>>>>error: $error');
      },
    );
  }

  void testEnd() {
    asrService?.dispose();
  }
}
