import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      // 页面
      'tab.home': '首页',
      'tab.chat': '聊天',
      'tab.role': '角色',
      'tab.profile': '我的',

      'tab_role.title': '角色',

      'edit_role.title': '编辑角色',
      'add_role.title': '添加角色',
      'add_role.name': '角色名称',
      'add_role.name.hint': '请输入角色名称',
      'add_role.description': '角色描述',
      'add_role.description.hint': '请输入角色描述',
      'add_role.icon': '角色图标',
      'add_role.success': '角色添加成功',
      'add_role.error': '角色添加失败',
      'edit_role.success': '角色编辑成功',
      'edit_role.error': '角色编辑失败',

      'role_detail.title': '角色详情',
      'role_detail.base_info': '基础信息',
      'role_detail.attachments': '附件',

      'attachments.title': '附件管理',
      'attachments.from.upload': '从本地上传',
      'attachments.from.create': '创建新文件',
      'attachments.from.cancel': '取消',
      'attachments.uploading': '上传中...',
      'attachments.upload.failed': '上传失败',
      'attachments.upload.success': '上传成功',
      'attachments.delete.loading': '删除中...',

      // 创建附件页面
      'create_attachment.title': '创建附件',
      'create_attachment.file_name.label': '文件名',
      'create_attachment.file_name.hint': '请输入文件名',
      'create_attachment.default_name': '未命名',
      'create_attachment.btn.save': '保存',
      'create_attachment.valid.name.cannot_empty': '文件名不能为空',
      'create_attachment.file_content.hint': '请输入文件内容',
      'create_attachment.save.success': '保存成功',
      'create_attachment.save.failed': '保存失败',
      'create_attachment.valid.name.already_exists': '文件名已存在',

      'btn.cancel': '取消',
      'btn.save': '保存',

      'snackbar.title': '提示',

      'language': 'zh_CN',
      'language.short': 'zh',

      'no_more_data': '没有更多数据了',

      'attachments.delete.title': '删除附件',
      'attachments.delete.content': '确定要删除附件“{filename}”吗？',
      'attachments.delete.confirm': '确定',
      'attachments.delete.cancel': '取消',
      'attachments.delete.success': '删除成功',
      'attachments.delete.failed': '删除失败',
    },
    'en_US': {
      // 页面
      'tab.home': 'Home',
      'tab.chat': 'Chat',
      'tab.role': 'Role',
      'tab.profile': 'Profile',

      'tab_role.title': 'Role',

      'edit_role.title': 'Edit Role',
      'add_role.title': 'Add Role',
      'add_role.name': 'Name',
      'add_role.name.hint': 'Please enter the role name',
      'add_role.description': 'Description',
      'add_role.description.hint': 'Please enter the role description',
      'add_role.icon': 'Icon',
      'add_role.success': 'Role added successfully',
      'add_role.error': 'Role added failed',
      'edit_role.success': 'Role edited successfully',
      'edit_role.error': 'Role edited failed',

      'role_detail.title': 'Role Detail',
      'role_detail.base_info': 'Base Info',
      'role_detail.attachments': 'Attachments',

      'attachments.title': 'Attachments',
      'attachments.from.upload': 'Upload from local',
      'attachments.from.create': 'Create new file',
      'attachments.from.cancel': 'Cancel',
      'attachments.uploading': 'Uploading...',
      'attachments.upload.failed': 'Upload Failed',
      'attachments.upload.success': 'Upload Success',
      'attachments.delete.loading': 'Deleting...',

      // 创建附件页面
      'create_attachment.title': 'Create Attachment',
      'create_attachment.file_name.label': 'File Name',
      'create_attachment.file_name.hint': 'Please enter the file name',
      'create_attachment.default_name': 'Untitled',
      'create_attachment.btn.save': 'Save',
      'create_attachment.valid.name.cannot_empty': 'File name cannot be empty',
      'create_attachment.file_content.hint': 'Please enter the file content',
      'create_attachment.save.success': 'Save Success',
      'create_attachment.save.failed': 'Save Failed',
      'create_attachment.valid.name.already_exists': 'File name already exists',

      'btn.cancel': 'Cancel',
      'btn.save': 'Save',

      'snackbar.title': 'Hint',

      'language': 'en_US',
      'language.short': 'en',

      'no_more_data': 'No more data',

      'attachments.delete.title': 'Delete Attachment',
      'attachments.delete.content':
          'Are you sure you want to delete the attachment “{filename}”?',
      'attachments.delete.confirm': 'Confirm',
      'attachments.delete.cancel': 'Cancel',
      'attachments.delete.success': 'Delete Success',
      'attachments.delete.failed': 'Delete Failed',
    },
  };
}
