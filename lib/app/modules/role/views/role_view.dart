import 'package:astrum/components/custom_loader/custom_loader.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:get/get.dart';

import '../controllers/role_controller.dart';

class RoleView extends GetView<RoleController> {
  const RoleView({super.key});

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.red,
            child: CachedNetworkImage(
              imageUrl:
                  controller.roles[index].icon ??
                  'https://img.liangqy.com/astrum/role_bg.png',
              width: Get.width,
              height: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            dense: true,
            title: Text(
              controller.roles[index].name,
              style: Get.theme.textTheme.titleMedium?.copyWith(),
            ),
            subtitle: Text(
              controller.roles[index].publishTime ?? '',
              style: Get.theme.textTheme.bodySmall?.copyWith(
                color: Get.theme.disabledColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            margin: EdgeInsets.only(top: 0, bottom: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              controller.roles[index].description ?? '',
              style: Get.theme.textTheme.bodySmall?.copyWith(
                color: Get.theme.hintColor,
              ),
            ),
          ),
          if (controller.roles[index].authorName != null &&
              controller.roles[index].authorName!.isNotEmpty)
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              margin: EdgeInsets.only(top: 0, bottom: 16),
              alignment: Alignment.centerLeft,
              child: Row(
                spacing: 8,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Get.theme.disabledColor.withValues(alpha: 0.1),
                    ),
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/svgs/tab_profile_selected.svg',
                      width: 14,
                      height: 14,
                    ),
                  ),
                  Text(
                    controller.roles[index].authorName ?? '',
                    style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: Get.theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'tab_role.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.gotoAddRole();
            },
            icon: SvgPicture.asset(
              'assets/svgs/icon_plus.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: FutureBuilder(
        future: controller.initRoleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CustomLoader());
          }
          return CustomMaterialIndicator(
            onRefresh: controller.onRefresh,
            child: GetBuilder(
              init: controller,
              id: 'update-roles',
              builder: (_) {
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.all(8),
                      sliver: SliverMasonryGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        itemBuilder: _buildItem,
                        childCount: controller.roles.length,
                      ),
                    ),
                    if (controller.pageIndex.value ==
                        controller.totalPage.value)
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
