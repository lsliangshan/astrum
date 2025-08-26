import 'dart:convert';
import 'package:astrum/database/daos/role.dao.dart';
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

  RoleDao roleDao = Get.find<RoleDao>();

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

    if (data['code'] == 200) {
      // 更新本地数据库中的role
      await roleDao.updateRole(
        id: id,
        name: name,
        description: description,
        icon: data['data']['icon'],
      );
    }
    return NormalResponse.fromJson(data);
  }

  /// 将服务器端数据库中的角色同步到本地数据库
  Future<NormalResponse> syncRoles({required String authorId}) async {
    if (authorId.isEmpty) {
      return NormalResponse(code: 200, message: 'success', data: {});
    }

    // 如果本地数据库中没有角色，则从服务器端数据库中获取角色
    final localRoles = await roleDao.getRoles(authorId: authorId);
    if (localRoles.code == 200 && localRoles.data['list'].isEmpty) {
      final serverRoles = await getRolesFromServer(
        authorId: authorId,
        include: 'self',
        pageIndex: 1,
        pageSize: 1000,
      );
      await roleDao.insertAll(roleList: serverRoles.data['list']);
    }
    return localRoles;
  }

  Future<void> deleteMyRoles({required String authorId}) async {
    await roleDao.deleteMyRoles(authorId: authorId);
  }

  Future<void> deleteUnforkedRoles() async {
    await roleDao.deleteUnforkedRoles();
  }

  Future<NormalResponse> getRolesFromServer({
    int pageIndex = 1,
    int pageSize = 20,
    String? authorId,
    // self others all
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

    var data = json.decode(response.body);

    data['data']['list'] = data['data']['list']
        .map<Role>((e) => Role.fromJson(e))
        .toList();

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> getRolesFromLocal({
    required String authorId,
    int pageIndex = 1,
    int pageSize = 20,
  }) async {
    final response = await roleDao.getRoles(
      authorId: authorId,
      pageIndex: pageIndex,
      pageSize: pageSize,
    );

    return response;
  }

  Future<Role?> getRoleDetailFromLocal({required String roleId}) async {
    final response = await roleDao.getRoleDetail(roleId: roleId);
    return response;
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

    if (data['code'] == 200 && data['data'] != null) {
      Role? localRoleDetail = await getRoleDetailFromLocal(roleId: roleId);
      if (localRoleDetail != null) {
        data['data']['isForked'] = localRoleDetail.isForked;
      } else {
        data['data']['isForked'] = false;
      }
    }

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> forkRole({
    required Role role,
    required String userId,
  }) async {
    if (userId.isEmpty) {
      return NormalResponse(
        code: 1001,
        message: '添加失败',
        data: {'roleId': role.id, 'userId': userId},
      );
    }
    final response = await roleDao.forkRole(role: role);
    if (response > 0) {
      return NormalResponse(
        code: 200,
        message: '添加成功',
        data: {'roleId': role.id, 'userId': userId},
      );
    }
    return NormalResponse(
      code: 1001,
      message: '添加失败',
      data: {'roleId': role.id, 'userId': userId},
    );
  }

  Future<NormalResponse> unforkRole({
    required Role role,
    required String userId,
  }) async {
    if (userId.isEmpty) {
      return NormalResponse(
        code: 1001,
        message: '移除失败',
        data: {'roleId': role.id, 'userId': userId},
      );
    }
    final response = await roleDao.unforkRole(role: role);
    if (response > 0) {
      return NormalResponse(
        code: 200,
        message: '移除成功',
        data: {'roleId': role.id, 'userId': userId},
      );
    }
    return NormalResponse(
      code: 1001,
      message: '移除失败',
      data: {'roleId': role.id, 'userId': userId},
    );
  }
}
