import 'dart:convert';

import 'package:astrum/database/daos/role.dao.dart';
import 'package:astrum/database/daos/user.dao.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/message.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart' hide Value;
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  final MessageService messageService = Get.find<MessageService>();
  UserDao userDao = Get.find<UserDao>();
  RoleDao roleDao = Get.find<RoleDao>();

  String defaultFemaleAvatar =
      'https://img.liangqy.com/astrum/astrum_default_logo_female.png';
  String defaultMaleAvatar =
      'https://img.liangqy.com/astrum/astrum_default_logo_male.png';

  RxBool isLogin = false.obs;

  Rx<User> user = User(id: '', username: '', password: '').obs;

  @override
  void onInit() {
    super.onInit();
    initLoginInfo();

    ever(isLogin, (value) {
      if (value) {
        messageService.initMessageService(userId: user.value.id);
      } else {
        messageService.destroyMessageService();
      }
    });

    ever(user, (value) {
      setDefaultAvatarIfNull();
    });
  }

  String getDefaultAvatar() {
    return user.value.gender == 'female'
        ? defaultFemaleAvatar
        : defaultMaleAvatar;
  }

  void setDefaultAvatarIfNull() {
    if (user.value.id.isEmpty) {
      return;
    }

    if (user.value.avatar == null || user.value.avatar!.isEmpty) {
      user.value = user.value.copyWith(
        avatar: Value(
          user.value.gender == 'female'
              ? defaultFemaleAvatar
              : defaultMaleAvatar,
        ),
      );
    }
  }

  Future<void> syncLoginInfo() async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/astrum/get-login-info'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'userId': user.value.id}),
    );
    if (response.body.isEmpty) {
      return;
    }

    final data = json.decode(response.body);
    if (data['code'] == 200 &&
        data['data'] != null &&
        data['data']['id'] != null) {
      user.value = User.fromJson(data['data']);
      isLogin.value = true;

      await userDao.login(user: user.value);
    }
  }

  Future<void> initLoginInfo() async {
    user.value = await userDao.getLoginInfo();
    if (user.value.token != null && user.value.token!.isNotEmpty) {
      isLogin.value = true;

      await syncLoginInfo();
    } else {
      isLogin.value = false;
    }
  }

  Future<NormalResponse> login({
    required String username,
    required String password,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/astrum/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.body.isEmpty) {
      return NormalResponse(code: 1001, message: '网络异常', data: {});
    }
    final data = json.decode(response.body);

    if (data['code'] == 200 && data['data'] != null) {
      user.value = User.fromJson(data['data']);
      isLogin.value = true;

      await userDao.login(user: user.value);
    }

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> register({
    required String username,
    required String password,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/astrum/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.body.isEmpty) {
      return NormalResponse(code: 1001, message: '网络异常', data: {});
    }
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<void> updateUserTokens({
    required String userId,
    required int tokens,
  }) async {
    await userDao.updateUserTokens(userId: userId, tokens: tokens);
    user.value = user.value.copyWith(tokens: Value(tokens));
  }

  void logout() {
    // 删除角色
    roleDao.deleteMyRoles(authorId: user.value.id);
    userDao.logout(user.value.id);
    user.value = User(id: '', username: '', password: '');
    isLogin.value = false;
  }
}
