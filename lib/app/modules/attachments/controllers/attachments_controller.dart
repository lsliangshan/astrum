import 'package:astrum/app/modules/create_attachment/views/create_attachment_view.dart';
import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/attachment.dart';
import 'package:astrum/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentsController extends GetxController {
  String roleId;
  String roleName;
  AttachmentsController({required this.roleId, required this.roleName});

  ToastService toastService = ToastService();
  AttachmentService attachmentService = AttachmentService();

  RxList<Attachment> attachments = <Attachment>[].obs;

  late Future<void> initAttachmentsFuture;

  @override
  void onInit() {
    super.onInit();

    initAttachmentsFuture = initData();
  }

  Future<void> initData() async {
    await initAttachments();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> initAttachments() async {
    NormalResponse response = await attachmentService.getAttachments(
      roleId: roleId,
    );

    if (response.code == 200 && response.data != null) {
      if (response.data!['list'] != null && response.data!['list'].isNotEmpty) {
        attachments.value = response.data!['list']
            .map<Attachment>((e) => Attachment.fromJson(e))
            .toList();
      } else {
        // 无数据
        attachments.clear();
      }
      update(['update-attachments']);
    }
  }

  Future<void> onRefresh() async {
    await initData();
  }

  Future<void> gotoCreateAttachment() async {
    Get.bottomSheet(
      Container(
        height: 200,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Card(
          color: Get.theme.colorScheme.surface,
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    'attachments.from.upload'.tr,
                    style: Get.theme.textTheme.bodyLarge,
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
                onTap: () {
                  // uploadAttachment();
                  Get.back();
                  toastService.showLoading(
                    message: 'attachments.uploading'.tr,
                    asyncFunction: () async {
                      await uploadAttachment();
                    },
                  );
                },
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(alpha: 0.04),
                indent: 8,
                endIndent: 8,
                thickness: 1,
              ),
              ListTile(
                title: Center(
                  child: Text(
                    'attachments.from.create'.tr,
                    style: Get.theme.textTheme.bodyLarge,
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
                tileColor: Get.theme.colorScheme.surface,
                onTap: () {
                  gotoUploadAttachment();
                },
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(alpha: 0.04),
                indent: 8,
                endIndent: 8,
                thickness: 1,
              ),
              ListTile(
                title: Center(
                  child: Text(
                    'attachments.from.cancel'.tr,
                    style: Get.theme.textTheme.bodyLarge?.copyWith(
                      color: Get.theme.colorScheme.error,
                    ),
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
                tileColor: Get.theme.colorScheme.surface,
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['txt', 'pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      NormalResponse response = await attachmentService
          .uploadAttachmentsByFiles(
            files: result.files.map((item) => XFile(item.path!)).toList(),
            roleId: roleId,
            roleName: roleName,
            authorId: '',
            authorName: '',
          );

      if (response.code == 200) {
        await initAttachments();
        toastService.showSuccess('attachments.upload.success'.tr);
      } else {
        toastService.showError('attachments.upload.failed'.tr);
      }
    }
  }

  Future<void> gotoUploadAttachment() async {
    Get.back();
    await Get.to(
      () => CreateAttachmentView(roleId: roleId, roleName: roleName),
    );
    await initAttachments();
  }

  Future<void> gotoFilePreviewer({
    required String fileUrl,
    required String attachmentId,
    required String fileName,
  }) async {
    if (fileName.endsWith('.txt')) {
      await Get.to(
        () => CreateAttachmentView(
          roleId: roleId,
          roleName: roleName,
          attachmentId: attachmentId,
        ),
      );
      await initAttachments();
    } else {
      Get.toNamed(
        Routes.FILE_PREVIEWER,
        arguments: {'fileUrl': fileUrl, 'fileName': fileName},
      );
    }
  }

  Future<void> deleteAttachmentConfirm({required String attachmentId}) async {
    NormalResponse response = await attachmentService.deleteAttachment(
      attachmentId: attachmentId,
    );
    if (response.code == 200) {
      await initAttachments();
      toastService.showSuccess('attachments.delete.success'.tr);
    } else {
      toastService.showError('attachments.delete.failed'.tr);
    }
  }

  Future<void> deleteAttachment({
    required String id,
    required String filename,
  }) async {
    Get.dialog(
      AlertDialog(
        title: Text('attachments.delete.title'.tr),
        content: Text(
          'attachments.delete.content'.tr.replaceAll('{filename}', filename),
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (Get.isDialogOpen != null && Get.isDialogOpen!) {
                Get.back();
              }
            },
            child: Text(
              'attachments.delete.cancel'.tr,
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ),
          FilledButton(
            onPressed: () async {
              if (Get.isDialogOpen != null && Get.isDialogOpen!) {
                Get.back();
              }
              toastService.showLoading(
                message: 'attachments.delete.loading'.tr,
                asyncFunction: () async {
                  await deleteAttachmentConfirm(attachmentId: id);
                },
              );
            },
            child: Text('attachments.delete.confirm'.tr),
          ),
        ],
      ),
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 200),
    );
  }
}
