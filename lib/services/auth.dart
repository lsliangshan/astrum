import 'dart:convert';

import 'package:astrum/database/daos/user.dao.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  UserDao userDao = Get.find<UserDao>();

  RxBool isLogin = false.obs;

  Rx<User> user = User(id: '', username: '', password: '').obs;

  @override
  void onInit() {
    super.onInit();
    initLoginInfo();
  }

  Future<void> initLoginInfo() async {
    user.value = await userDao.getLoginInfo();
    print(">>>>>>>>>>>> ${user.value.toJson()}");
    isLogin.value = true;
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
    print('>>>>>> 用户注册 ${response.body}');
    if (response.body.isEmpty) {
      return NormalResponse(code: 1001, message: '网络异常', data: {});
    }
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  void logout() {
    isLogin.value = false;
  }
}
