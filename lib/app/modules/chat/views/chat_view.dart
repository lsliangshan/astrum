import 'package:astrum/components/custom_loader/custom_loader.dart';
import 'package:astrum/components/empty_result/empty_result.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 0,
      child: ListTile(
        onTap: () {
          controller.gotoChatDetail(role: controller.roles[index]);
        },
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(6),
          ),
          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            imageUrl:
                controller.roles[index].icon ??
                'https://img.liangqy.com/astrum/role_bg.png',
            width: Get.width,
            height: 100,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(child: CustomLoader()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        title: Text(
          controller.roles[index].name,
          style: Get.theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${controller.roles[index].description}',
          style: Get.theme.textTheme.bodySmall?.copyWith(
            color: Get.theme.disabledColor,
          ),
        ),
        shape: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 0.5)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tab.chat'.tr, style: Get.theme.textTheme.titleMedium),
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
        centerTitle: true,
      ),
      backgroundColor: Get.theme.colorScheme.surface,
      body: FutureBuilder(
        future: controller.initChatsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CustomLoader());
          }
          return CustomMaterialIndicator(
            onRefresh: controller.onRefresh,
            child: GetBuilder(
              init: controller,
              id: 'update-chats',
              builder: (_) {
                if (controller.roles.isEmpty) {
                  return ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: Get.height - 300,
                        child: Center(
                          child: EmptyResult(showMainButton: false),
                        ),
                      ),
                    ],
                  );
                }
                return CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemBuilder: _buildItem,
                      itemCount: controller.roles.length,
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
