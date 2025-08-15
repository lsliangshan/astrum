import 'package:astrum/app/modules/login/views/login_box_view.dart';
import 'package:astrum/app/modules/login/views/register_box_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://img.liangqy.com/astrum/login_bg.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 8,
            child: Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/svgs/icon_close.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    Color(0xFF000000),
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: Get.width,
            height: Get.height,
            child: GetBuilder(
              init: controller,
              builder: (_) {
                if (controller.isLoginMode.isTrue) {
                  return LoginBoxView();
                } else {
                  return RegisterBoxView();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
