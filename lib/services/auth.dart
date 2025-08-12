import 'dart:convert';

import 'package:astrum/database/daos/user.dao.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/message.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  final MessageService messageService = Get.find<MessageService>();
  UserDao userDao = Get.find<UserDao>();

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
  }

  Future<void> initLoginInfo() async {
    user.value = await userDao.getLoginInfo();
    if (user.value.token != null && user.value.token!.isNotEmpty) {
      isLogin.value = true;
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

    user.value = User.fromJson(data['data']);

    isLogin.value = true;

    await userDao.login(user: user.value);

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

  void logout() {
    userDao.logout(user.value.id);
    user.value = User(id: '', username: '', password: '');
    isLogin.value = false;
  }
}
