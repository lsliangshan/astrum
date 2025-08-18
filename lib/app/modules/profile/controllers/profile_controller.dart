import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/tencent_asr.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  AuthService authService = Get.find<AuthService>();

  Rx<User> get user => authService.user;
  RxBool get isLogin => authService.isLogin;

  RxList<String> asrResult = <String>[].obs;

  TencentAsrService? asrService;

  @override
  void onInit() {
    super.onInit();
  }

  void gotoLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  void logout() {
    authService.logout();
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
