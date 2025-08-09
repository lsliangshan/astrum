import 'package:astrum/components/custom_backward_view/custom_backward_view.dart';
import 'package:astrum/components/custom_loader/custom_loader.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/attachments_controller.dart';

class AttachmentsView extends GetView {
  final String roleId;
  final String roleName;
  AttachmentsView({super.key, required this.roleId, required this.roleName}) {
    Get.put(
      AttachmentsController(roleId: roleId, roleName: roleName),
      tag: 'attachments-$roleId',
    );
  }

  @override
  AttachmentsController get controller =>
      Get.find<AttachmentsController>(tag: 'attachments-$roleId');

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      color: Colors.white,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: () {
          controller.gotoFilePreviewer(
            fileUrl: controller.attachments[index].url,
            attachmentId: controller.attachments[index].id,
            fileName: controller.attachments[index].filename,
          );
        },
        title: Text(
          controller.attachments[index].filename,
          style: Get.theme.textTheme.titleSmall,
        ),
        trailing: IconButton(
          onPressed: () {
            controller.deleteAttachment(
              id: controller.attachments[index].id,
              filename: controller.attachments[index].filename,
            );
          },
          icon: SvgPicture.asset(
            'assets/svgs/icon_close.svg',
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(
              Get.theme.colorScheme.error.withValues(alpha: 0.88),
              BlendMode.srcIn,
            ),
          ),
        ),
        contentPadding: EdgeInsets.only(left: 16, right: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.attachments.isNotEmpty &&
                    controller.attachments.first.roleName != null &&
                    controller.attachments.first.roleName!.isNotEmpty
                ? '[${controller.attachments.first.roleName}]${"attachments.title".tr}'
                : 'attachments.title'.tr,
            style: Get.theme.textTheme.titleMedium,
          ),
        ),
        centerTitle: true,
        leading: CustomBackwardView(),
        actions: [
          IconButton(
            onPressed: () {
              controller.gotoCreateAttachment();
            },
            icon: SvgPicture.asset(
              'assets/svgs/icon_plus.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder(
        future: controller.initAttachmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CustomLoader());
          }
          return CustomMaterialIndicator(
            onRefresh: controller.onRefresh,
            child: GetBuilder(
              init: controller,
              id: 'update-attachments',
              builder: (_) {
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.all(8),
                      sliver: SliverList.builder(
                        itemBuilder: _buildItem,
                        itemCount: controller.attachments.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        child: Text(
                          'no_more_data'.tr,
                          textAlign: TextAlign.center,
                          style: Get.theme.textTheme.bodySmall?.copyWith(
                            color: Get.theme.disabledColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
