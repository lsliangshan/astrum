import 'dart:convert';
import 'package:astrum/database/database.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:astrum/services/auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class RoleService extends GetxService {
  AuthService authService = Get.find<AuthService>();

  Rx<User> get loginInfo => authService.user;

  Future<NormalResponse> addRole({
    required String name,
    String? description,
    XFile? icon,
  }) async {
    final uri = Uri.parse(
      'https://wf.liangqy.com/webhook/astrum/add-role',
    ); // 替换成你的实际 URL
    final request = http.MultipartRequest('POST', uri)
      ..fields['name'] = Uri.encodeComponent(name)
      ..fields['description'] = Uri.encodeComponent(description ?? '')
      ..fields['authorId'] = Uri.encodeComponent(loginInfo.value.id)
      ..fields['authorName'] = Uri.encodeComponent(loginInfo.value.username);

    if (icon != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          icon!.path,
          filename: icon.name,
          contentType: MediaType.parse(
            lookupMimeType(icon.name) ?? 'image/png',
          ),
        ),
      );
    }

    final response = await request.send().timeout(Duration(minutes: 30));

    final data = json.decode(await response.stream.bytesToString());
    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> editRole({
    required String id,
    String? name,
    String? description,
    XFile? icon,
  }) async {
    final uri = Uri.parse(
      'https://wf.liangqy.com/webhook/astrum/edit-role',
    ); // 替换成你的实际 URL
    final request = http.MultipartRequest('POST', uri)
      ..fields['id'] = Uri.encodeComponent(id)
      ..fields['authorId'] = Uri.encodeComponent(loginInfo.value.id)
      ..fields['authorName'] = Uri.encodeComponent(loginInfo.value.username);

    if (name != null && name.isNotEmpty) {
      request.fields['name'] = Uri.encodeComponent(name);
    }

    if (description != null && description.isNotEmpty) {
      request.fields['description'] = Uri.encodeComponent(description);
    }

    if (icon != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          icon.path,
          filename: icon.name,
          contentType: MediaType.parse(
            lookupMimeType(icon.name) ?? 'image/png',
          ),
        ),
      );
    }

    final response = await request.send().timeout(Duration(minutes: 30));

    final data = json.decode(await response.stream.bytesToString());
    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> getRoles({
    int pageIndex = 1,
    int pageSize = 20,
    String? authorId,
    String? include = 'all',
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/astrum/get-roles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'pageIndex': '$pageIndex',
        'pageSize': '$pageSize',
        'authorId': authorId ?? '',
        'include': include ?? 'all',
      }),
    );

    if (response.body.isEmpty) {
      return NormalResponse(code: 1001, message: '网络异常', data: {});
    }

    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> getRoleDetail({required String roleId}) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/astrum/get-role-detail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'roleId': roleId}),
    );

    if (response.body.isEmpty) {
      return NormalResponse(code: 1001, message: '网络异常', data: {});
    }

    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }
}
