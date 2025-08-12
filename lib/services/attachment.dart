import 'dart:convert';
import 'dart:io';
import 'package:astrum/models/normal_response.model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class AttachmentService extends GetxService {
  Future<NormalResponse> getAttachments({
    String? roleId,
    String? authorId,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/astrum/get-attachments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'roleId': roleId, 'authorId': authorId}),
    );

    if (response.body.isEmpty) {
      return NormalResponse(code: 1001, message: '网络异常', data: {});
    }
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> deleteAttachment({
    required String attachmentId,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/astrum/delete-attachment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'attachmentId': attachmentId}),
    );

    if (response.body.isEmpty) {
      return NormalResponse(code: 1001, message: '网络异常', data: {});
    }
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> getAttachmentDetail({
    required String attachmentId,
  }) async {
    final response = await http.get(
      Uri.parse(
        'https://wf.liangqy.com/webhook/astrum/get-attachment-detail?attachmentId=$attachmentId',
      ),
    );
    if (response.body.isEmpty) {
      return NormalResponse(code: 1001, message: '网络异常', data: {});
    }
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> uploadAttachment({
    required String content,
    required String filename,
    required String roleId,
    required String roleName,
    String? authorId,
    String? authorName,
    String? attachmentId,
  }) async {
    File? file;

    // 1. 获取临时目录
    final directory = await getTemporaryDirectory();
    final filePath = path.join(directory.path, filename);

    // 2. 写入文件
    file = File(filePath);
    await file.writeAsString(content);

    // 3. 构建 Multipart 请求
    final uri = Uri.parse(
      'https://wf.liangqy.com/webhook/astrum/add-attachments',
    ); // 替换成你的实际 URL
    final request = http.MultipartRequest('POST', uri)
      ..fields['roleId'] = roleId
      ..fields['roleName'] = Uri.encodeComponent(roleName);

    if (authorId != null && authorId.isNotEmpty) {
      request.fields['authorId'] = authorId;
    }
    if (authorName != null && authorName.isNotEmpty) {
      request.fields['authorName'] = authorName;
    }

    if (attachmentId != null && attachmentId.isNotEmpty) {
      request.fields['attachmentId'] = attachmentId;
    }

    final bytes = utf8.encode(content);
    final multipartFile = http.MultipartFile.fromBytes(
      'files', // 字段名
      bytes, // 内容
      filename: '$filename.txt',
      contentType: MediaType('text', 'plain'),
    );

    request.files.add(multipartFile);

    // 4. 发送请求
    final response = await request.send();

    final data = json.decode(await response.stream.bytesToString());

    if (await file.exists()) {
      try {
        await file.delete();
      } catch (_) {}
    }

    // 5. 响应处理
    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> uploadAttachmentsByFiles({
    required List<XFile> files,
    required String roleId,
    required String roleName,
    String? authorId,
    String? authorName,
  }) async {
    final uri = Uri.parse(
      'https://wf.liangqy.com/webhook/astrum/add-attachments',
    ); // 替换成你的实际 URL
    final request = http.MultipartRequest('POST', uri)
      ..fields['roleId'] = roleId
      ..fields['roleName'] = Uri.encodeComponent(roleName);

    if (authorId != null && authorId.isNotEmpty) {
      request.fields['authorId'] = authorId;
    }
    if (authorName != null && authorName.isNotEmpty) {
      request.fields['authorName'] = authorName;
    }

    for (XFile file in files) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'files',
          file.path,
          filename: file.name,
          contentType: MediaType.parse(
            lookupMimeType(file.name) ?? 'text/plain',
          ),
        ),
      );
    }

    final response = await request.send().timeout(Duration(minutes: 30));

    final data = json.decode(await response.stream.bytesToString());

    print('>>>>>>>request: ${data}');

    return NormalResponse.fromJson(data);
  }

  Future<String> getFileContent({required String fileUrl}) async {
    final response = await http.get(Uri.parse(fileUrl));
    return utf8.decode(response.bodyBytes);
  }
}
