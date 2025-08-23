import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/localstorage.dart';
import 'package:astrum/services/toast.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
  // UserService userService = Get.find<UserService>();
  // AppleService appleService = Get.find<AppleService>();
  // ImageService imageService = Get.find<ImageService>();
  // MemberService memberService = Get.find<MemberService>();
  // EventBus eventBus = Get.find<EventBus>();
  ToastService toastService = Get.find<ToastService>();
  LocalstorageService localstorageService = Get.find<LocalstorageService>();
  AuthService authService = Get.find<AuthService>();

  Rx<User> get user => authService.user;
  RxBool get isLogin => authService.isLogin;

  late Future<void> initFuture;

  Rx<String> currentLanguage = 'zh_CN'.obs;

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

    initLanguage();

    initFuture = initData();
  }

  Future<void> initData() async {
    return Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> initLanguage() async {
    String localLanguage =
        (await localstorageService.getString(LocalLanguageKey)) ?? '';
    currentLanguage.value = (localLanguage != '')
        ? localLanguage
        : languages[0]['value']!;
  }

  void gotoActivationCode() async {
    if (isLogin.isFalse) {
      // 请先登录
      toastService.showError('need.login'.tr);

      return;
    }
    var result = await Get.toNamed(Routes.ACTIVATION_CODE);
    if (result == true) {}
  }

  void openUrl({String? url, String? title}) async {
    if (url != null) {
      Get.toNamed(Routes.WEBVIEW, arguments: {'url': url, 'title': title});
    }
  }
}
