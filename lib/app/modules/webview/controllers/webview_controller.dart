import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebviewController extends GetxController {
  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
  }

  void onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;
  }
}
