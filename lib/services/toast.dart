import 'dart:ui';

import 'package:astrum/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ToastService extends GetxService {
  void showError(String message) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      'snackbar.title'.tr,
      message,
      colorText: Get.theme.colorScheme.onError,
      backgroundColor: Get.theme.colorScheme.errorContainer,
    );
  }

  void showSuccess(String message) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      'snackbar.title'.tr,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  void showLoading<T>({
    required Future<T> Function() asyncFunction,
    String? message,
  }) {
    Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: Center(
        child: LoaderOverlay(
          overlayColor: Colors.transparent,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomLoader(color: Get.theme.colorScheme.surface),
                            SizedBox(height: 24),
                            Text(
                              message ?? 'toast.uploading'.tr,
                              textAlign: TextAlign.center,
                              style: Get.theme.textTheme.bodyMedium?.copyWith(
                                color: Get.theme.colorScheme.surface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
