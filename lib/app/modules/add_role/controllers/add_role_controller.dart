import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/role.dart';
import 'package:astrum/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Value;
import 'package:drift/drift.dart' show Value;
import 'package:image_picker/image_picker.dart';

class AddRoleController extends GetxController {
  String? roleId;
  AddRoleController({this.roleId});

  RoleService roleService = Get.find<RoleService>();
  ToastService toastService = Get.find<ToastService>();
  AuthService authService = Get.find<AuthService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController promptController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode promptFocusNode = FocusNode();

  final Rx<XFile?> roleIcon = Rx<XFile?>(null);

  Rx<Role> formData = Role(id: '', name: '').obs;

  RxBool get isLogin => authService.isLogin;

  Rx<bool> isLoading = false.obs;

  Rx<Role> role = Role(id: '', name: '').obs;

  late Future<void> initRoleDetailFuture;

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

    promptController.addListener(() {
      formData.value = formData.value.copyWith(
        prompt: Value<String?>(promptController.text),
      );
    });

    initRoleDetailFuture = initData();

    ever(isLogin, (value) {
      if (value) {
        update(['update-role']);
      }
    });
  }

  Future<void> initData() async {
    if (roleId == null || roleId!.isEmpty) {
      return;
    }

    final response = await roleService.getRoleDetail(roleId: roleId!);

    if (response.code == 200 && response.data != null) {
      role.value = Role.fromJson(response.data);

      formData.value = formData.value.copyWith(
        name: role.value.name,
        description: Value<String?>(role.value.description),
        icon: Value<String?>(role.value.icon),
        authorId: Value<String?>(role.value.authorId),
        authorName: Value<String?>(role.value.authorName),
        publishTime: Value<String?>(role.value.publishTime),
        createAt: Value<String?>(role.value.createAt),
        updateAt: Value<String?>(role.value.updateAt),
      );

      nameController.text = role.value.name;
      descriptionController.text = role.value.description ?? '';
      promptController.text = role.value.prompt ?? '';

      update(['update-role']);
    }
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

    if (roleIcon.value == null &&
        (formData.value.icon == null || formData.value.icon!.isEmpty)) {
      toastService.showError('add_role.icon.hint'.tr);
      return;
    }

    if (isLoading.value) {
      return;
    }

    isLoading.value = true;

    NormalResponse response;

    if (roleId == null || roleId!.isEmpty) {
      // 添加角色
      response = await roleService.addRole(
        name: nameController.text,
        description: descriptionController.text,
        prompt: promptController.text,
        icon: roleIcon.value,
      );
    } else {
      // 编辑角色
      response = await roleService.editRole(
        id: roleId!,
        name: nameController.text,
        description: descriptionController.text,
        prompt: promptController.text,
        icon: roleIcon.value,
      );
    }

    if (response.code == 200) {
      Get.back();
      toastService.showSuccess(
        roleId == null || roleId!.isEmpty
            ? 'add_role.success'.tr
            : 'edit_role.success'.tr,
      );
    } else {
      toastService.showError(
        response.message ??
            (roleId == null || roleId!.isEmpty
                ? 'add_role.error'.tr
                : 'edit_role.error'.tr),
      );
    }

    isLoading.value = false;
  }

  void gotoLogin() {
    Get.toNamed(Routes.LOGIN);
  }
}
