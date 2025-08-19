import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/attachment.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAttachmentController extends GetxController {
  String roleId;
  String roleName;
  String? attachmentId;
  CreateAttachmentController({
    required this.roleId,
    required this.roleName,
    this.attachmentId,
  });

  AttachmentService attachmentService = Get.find<AttachmentService>();
  ToastService toastService = Get.find<ToastService>();
  AuthService authService = Get.find<AuthService>();

  late Future<void> initCreateAttachmentFuture;

  TextEditingController fileNameController = TextEditingController(
    text: 'create_attachment.default_name'.tr,
  );

  TextEditingController fileContentController = TextEditingController();

  FocusNode fileNameFocusNode = FocusNode();
  FocusNode fileContentFocusNode = FocusNode();

  RxList<Attachment> attachments = <Attachment>[].obs;

  Rx<Attachment> attachmentDetail = Attachment(
    id: "",
    filename: '',
    url: '',
  ).obs;

  RxBool get isLogin => authService.isLogin;

  Rx<bool> isCreating = false.obs;

  @override
  void onInit() {
    super.onInit();

    initCreateAttachmentFuture = initData();
  }

  Future<void> initData() async {
    await initAttachmentDetail();

    if (attachmentDetail.value.filename.isNotEmpty) {
      fileNameController.text = attachmentDetail.value.filename.replaceAll(
        RegExp(r'\.txt$'),
        '',
      );
    }

    if (attachmentDetail.value.url.isNotEmpty) {
      fileContentController.text = await attachmentService.getFileContent(
        fileUrl: attachmentDetail.value.url,
      );
    }

    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> initAttachmentDetail() async {
    if (attachmentId == null || attachmentId!.isEmpty) {
      return;
    }

    NormalResponse normalResponse = await attachmentService.getAttachmentDetail(
      attachmentId: attachmentId!,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      attachmentDetail.value = Attachment.fromJson(normalResponse.data!);
      update(['update-create-attachment']);
    }
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

  Future<void> saveAttachment() async {
    if (fileNameController.text.isEmpty ||
        fileNameController.text.trim() == 'create_attachment.default_name'.tr) {
      toastService.showError('create_attachment.valid.name.cannot_empty'.tr);
      fileNameFocusNode.requestFocus();
      return;
    }

    if (isCreating.value) {
      return;
    }

    if (attachmentId == null || attachmentId!.isEmpty) {
      await initAttachments();

      if (attachments.any(
        (element) =>
            element.filename.replaceAll(RegExp(r'\.txt$'), '') ==
            fileNameController.text,
      )) {
        toastService.showError(
          'create_attachment.valid.name.already_exists'.tr,
        );
        fileNameFocusNode.requestFocus();
        return;
      }
    }

    isCreating.value = true;

    NormalResponse normalResponse = await attachmentService.uploadAttachment(
      attachmentId: attachmentId,
      content: fileContentController.text,
      filename: fileNameController.text,
      roleId: roleId,
      roleName: roleName,
    );
    if (normalResponse.code == 200) {
      Get.back(result: true);
      toastService.showSuccess('create_attachment.save.success'.tr);
    } else {
      toastService.showError('create_attachment.save.failed'.tr);
    }

    isCreating.value = false;
  }
}
