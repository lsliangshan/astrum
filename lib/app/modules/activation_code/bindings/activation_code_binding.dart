import 'package:get/get.dart';

import '../controllers/activation_code_controller.dart';

class ActivationCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivationCodeController>(
      () => ActivationCodeController(),
    );
  }
}
