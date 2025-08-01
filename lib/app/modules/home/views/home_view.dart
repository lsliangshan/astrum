import 'package:astrum/app/modules/home/views/custom_bottom_navigation_bar_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: Get.width,
        height: Get.height,
        child: CachedNetworkImage(
          imageUrl: 'https://img.liangqy.com/astrum/astrum_bg.jpeg',
          fit: BoxFit.fitWidth,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBarView(),
    );
  }
}
