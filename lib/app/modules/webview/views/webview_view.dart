import 'package:astrum/components/custom_backward_view/custom_backward_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';

import '../controllers/webview_controller.dart';

class WebviewView extends GetView<WebviewController> {
  final String? url;
  final String? title;
  const WebviewView({super.key, this.url, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              leading: const CustomBackwardView(),
            )
          : null,
      body: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: InAppWebView(
              // key: UniqueKey(),
              initialUrlRequest: URLRequest(url: WebUri(url!)),
              // initialUrlRequest: URLRequest(url: WebUri('http://127.0.0.1:5173')),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                transparentBackground: true,
              ),
              onWebViewCreated: controller.onWebViewCreated,
              onLoadStop: (ctrl, url) async {
                // await Future.delayed(Duration(milliseconds: 100));
                // await ctrl.evaluateJavascript(source: controller.initDataStr);
              },
              onConsoleMessage: (controller, consoleMessage) {
                // print(consoleMessage);
                // it will print: {message: {"foo":1,"bar":false}, messageLevel: 1}
              },
            ),
          ),
          const Positioned(
            top: 24,
            right: 12,
            child: CloseButton(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
