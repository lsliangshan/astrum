import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/utils/utils.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  AuthService authService = Get.find<AuthService>();

  Rx<User> get user => authService.user;
  RxBool get isLogin => authService.isLogin;

  @override
  void onInit() {
    super.onInit();

    String text = '⏳';

    int tokens2 = countTokens(text);
    print('>>>>>>>countTokens: $tokens2');
  }

  void gotoLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  void logout() {
    authService.logout();
  }
}
