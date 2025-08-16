import 'package:astrum/components/custom_backward_view/custom_backward_view.dart';
import 'package:astrum/components/custom_loader/custom_loader.dart';
import 'package:astrum/database/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/role_detail_controller.dart';

// ignore: must_be_immutable
class RoleDetailView extends GetView {
  String roleId;
  RoleDetailView({super.key, required this.roleId}) {
    if (roleId.isNotEmpty) {
      Get.put<RoleDetailController>(
        RoleDetailController(roleId: roleId),
        tag: 'role-detail-$roleId',
      );
    }
  }

  @override
  RoleDetailController get controller => Get.find(tag: 'role-detail-$roleId');

  Widget _renderBaseInfoCard() {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(left: 12, right: 12, top: 12),
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              'role_detail.base_info'.tr,
              style: Get.theme.textTheme.bodyMedium,
            ),
            trailing: IconButton(
              onPressed: () {
                controller.gotoEditRole();
              },
              icon: SvgPicture.asset(
                'assets/svgs/icon_edit_filled.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  Get.theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  BlendMode.srcIn,
                ),
              ),
              iconSize: 18,
            ),
            contentPadding: EdgeInsets.only(right: 0, left: 16),
          ),
          Divider(
            height: 1,
            color: Get.theme.dividerColor.withValues(alpha: 0.05),
          ),
          Obx(
            () => ListTile(
              title: Text(
                controller.role.value.description ?? '',
                style: Get.theme.textTheme.bodySmall,
              ),
              leading: controller.role.value.icon != null
                  ? Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: controller.role.value.icon!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox.shrink(),
              titleAlignment: ListTileTitleAlignment.top,
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _renderAttachmentsCard() {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(left: 12, right: 12, top: 12),
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              'role_detail.attachments'.tr,
              style: Get.theme.textTheme.bodyMedium,
            ),
            trailing: IconButton(
              onPressed: () {
                controller.gotoAttachments();
              },
              icon: SvgPicture.asset(
                'assets/svgs/icon_edit_filled.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  Get.theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  BlendMode.srcIn,
                ),
              ),
              iconSize: 18,
            ),
            contentPadding: EdgeInsets.only(right: 0, left: 16),
          ),
          Divider(
            height: 1,
            color: Get.theme.dividerColor.withValues(alpha: 0.05),
          ),
          SizedBox(height: 12),
          for (var attachment in controller.attachments)
            _buildAttachmentItem(attachment),
          if (controller.attachments.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Center(
                child: Text(
                  'role_detail.no_attachments.tip'.tr,
                  style: Get.theme.textTheme.bodySmall?.copyWith(
                    color: Get.theme.colorScheme.onSurface.withValues(
                      alpha: 0.4,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(Attachment attachment) {
    return Card(
      color: Colors.white,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: () {
          controller.gotoFilePreviewer(
            fileUrl: attachment.url,
            attachmentId: attachment.id,
            fileName: attachment.filename,
          );
        },
        leading: SvgPicture.asset(
          'assets/svgs/icon_document.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            Get.theme.colorScheme.onSurface.withValues(alpha: 0.48),
            BlendMode.srcIn,
          ),
        ),
        title: Text(
          attachment.filename,
          style: Get.theme.textTheme.titleSmall?.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.48),
          ),
        ),
        trailing: SvgPicture.asset(
          'assets/svgs/icon_arrow_right.svg',
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(
            Get.theme.colorScheme.onSurface.withValues(alpha: 0.4),
            BlendMode.srcIn,
          ),
        ),
        visualDensity: VisualDensity.compact,
        dense: true,
        contentPadding: EdgeInsets.only(left: 16, right: 16),
      ),
    );
  }

  Widget _renderChatCard() {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(left: 12, right: 12, top: 12),
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              'role_detail.chat'.tr,
              style: Get.theme.textTheme.bodyMedium,
            ),
            trailing: IconButton(
              onPressed: () {
                controller.gotoEditRole();
              },
              icon: SvgPicture.asset(
                'assets/svgs/icon_edit_filled.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  Get.theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  BlendMode.srcIn,
                ),
              ),
              iconSize: 18,
            ),
            contentPadding: EdgeInsets.only(right: 0, left: 16),
          ),
          Divider(
            height: 1,
            color: Get.theme.dividerColor.withValues(alpha: 0.05),
          ),
          Obx(
            () => ListTile(
              title: Text(
                controller.role.value.description ?? '',
                style: Get.theme.textTheme.bodySmall,
              ),
              leading: controller.role.value.icon != null
                  ? Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: controller.role.value.icon!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox.shrink(),
              titleAlignment: ListTileTitleAlignment.top,
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.role.value.name.isNotEmpty
                ? controller.role.value.name
                : 'role_detail.title'.tr,
            style: Get.theme.textTheme.titleMedium,
          ),
        ),
        centerTitle: true,
        leading: CustomBackwardView(),
        actions: [
          IconButton(
            onPressed: () {
              controller.gotoChatDetail();
            },
            icon: SvgPicture.asset(
              'assets/svgs/icon_chat_filled.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Get.theme.colorScheme.onSurface.withValues(alpha: 0.68),
                BlendMode.srcIn,
              ),
            ),
            iconSize: 18,
          ),
          SizedBox(width: 12),
        ],
      ),
      body: FutureBuilder(
        future: controller.initRoleDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CustomLoader());
          }
          return CustomMaterialIndicator(
            onRefresh: controller.onRefresh,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _renderBaseInfoCard()),
                SliverToBoxAdapter(child: _renderAttachmentsCard()),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.gotoChatDetail();
        },
        mini: true,
        child: SvgPicture.asset(
          'assets/svgs/icon_chat_filled.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Get.theme.colorScheme.onSurface.withValues(alpha: 0.68),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
