import 'package:astrum/app/modules/add_role/views/add_role_view.dart';
import 'package:astrum/app/modules/attachments/views/attachments_view.dart';
import 'package:astrum/app/modules/chat_detail/views/chat_detail_view.dart';
import 'package:astrum/app/modules/create_attachment/views/create_attachment_view.dart';
import 'package:astrum/app/routes/app_pages.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/attachment.dart';
import 'package:astrum/services/role.dart';
import 'package:get/get.dart';

class RoleDetailController extends GetxController {
  String roleId;
  RoleDetailController({required this.roleId});

  RoleService roleService = Get.find<RoleService>();
  AttachmentService attachmentService = Get.find<AttachmentService>();

  Rx<Role> role = Role(id: '', name: '').obs;

  RxList<Attachment> attachments = <Attachment>[].obs;

  late Future<void> initRoleDetailFuture;

  @override
  void onInit() {
    super.onInit();

    initRoleDetailFuture = initData();
  }

  Future<void> initData() async {
    final response = await roleService.getRoleDetail(roleId: roleId);

    if (response.code == 200 && response.data != null) {
      role.value = Role.fromJson(response.data);
    }

    await initAttachments();

    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> gotoEditRole() async {
    await Get.to(() => AddRoleView(roleId: roleId));

    await initData();
  }

  Future<void> onRefresh() async {
    await initData();
  }

  Future<void> gotoAttachments() async {
    await Get.to(
      () => AttachmentsView(roleId: roleId, roleName: role.value.name),
    );
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

  Future<void> gotoFilePreviewer({
    required String fileUrl,
    required String attachmentId,
    required String fileName,
  }) async {
    if (fileName.endsWith('.txt')) {
      await Get.to(
        () => CreateAttachmentView(
          roleId: roleId,
          roleName: role.value.name,
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

  Future<void> gotoChatDetail() async {
    await Get.to(
      () => ChatDetailView(roleId: roleId, roleName: role.value.name),
    );
  }
}
