import 'package:get/get.dart';

import '../controllers/add_attachment_controller.dart';

class AddAttachmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAttachmentController>(
      () => AddAttachmentController(),
    );
  }
}
