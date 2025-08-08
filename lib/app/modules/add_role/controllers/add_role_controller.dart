import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/role.dart';
import 'package:astrum/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Value;
import 'package:drift/drift.dart' show Value;
import 'package:image_picker/image_picker.dart';

class AddRoleController extends GetxController {
  RoleService roleService = Get.find<RoleService>();
  ToastService toastService = Get.find<ToastService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  final Rx<XFile?> roleIcon = Rx<XFile?>(null);

  Rx<Role> formData = Role(id: '', name: '').obs;

  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(() {
      formData.value = formData.value.copyWith(name: nameController.text);
    });

    descriptionController.addListener(() {
      formData.value = formData.value.copyWith(
        description: Value<String?>(descriptionController.text),
      );
    });
  }

  void selectRoleLogo() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      roleIcon.value = result;
    }
  }

  void goBack() {
    Get.back();
  }

  Future<void> saveRole() async {
    if (nameController.text.isEmpty) {
      toastService.showError('add_role.name.hint'.tr);

      nameFocusNode.requestFocus();
      return;
    }

    if (isLoading.value) {
      return;
    }

    isLoading.value = true;

    NormalResponse response = await roleService.addRole(
      name: nameController.text,
      description: descriptionController.text,
      icon: roleIcon.value,
    );

    if (response.code == 200) {
      Get.back();
      toastService.showSuccess('add_role.success'.tr);
    } else {
      toastService.showError(response.message ?? 'add_role.error'.tr);
    }

    isLoading.value = false;
  }
}
