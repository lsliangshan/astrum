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

      'tab_chat.title': '聊天列表',

      'edit_role.title': '编辑角色',
      'add_role.title': '添加角色',
      'add_role.name': '角色名称',
      'add_role.name.hint': '请输入角色名称',
      'add_role.description': '角色描述',
      'add_role.description.hint': '请输入角色描述',
      'add_role.icon': '角色图标',
      'add_role.icon.hint': '请选择图标',
      'add_role.success': '角色添加成功',
      'add_role.error': '角色添加失败',

      'edit_role.success': '角色编辑成功',
      'edit_role.error': '角色编辑失败',

      'role_detail.title': '角色详情',
      'role_detail.base_info': '基础信息',
      'role_detail.attachments': '附件',
      'role_detail.no_attachments.tip': '暂无附件',
      'role_detail.chat': '聊天',
      'role_detail.authorName': '作者',
      'role_detail.btn_chat': '开始聊天',
      'role_detail.btn_fork': '添加到我的角色库',
      'role_detail.btn_unfork': '从我的角色库中移除',
      'role_detail.btn_add_role': '添加角色',
      'role_detail.add_role.success': '添加成功',
      'role_detail.add_role.failed': '添加失败',
      'role_detail.delete_role.success': '删除成功',
      'role_detail.delete_role.failed': '删除失败',

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

      'login.login.title': '登录',
      'login.login.btn': '登录',
      'login.login.success': '登录成功',
      'login.login.error.username_not_exist': '用户名不存在',
      'login.login.error.password_error': '密码错误',
      'login.login.error.unknown': '登录失败，请稍后再试',
      'login.register.title': '注册',
      'login.register.btn': '注册',
      'login.register.success': '注册成功',
      'login.register.error.unknown': '注册失败，请稍后再试',
      'login.valid.username.can_not_empty': '用户名不能为空',
      'login.valid.password.can_not_empty': '密码不能为空',
      'login.valid.confirm_password.can_not_empty': '确认密码不能为空',
      'login.valid.confirm_password.not_match': '确认密码不匹配',
      'login.has_account': '已有账号，去登录',
      'login.no_account': '没有账号，去注册',
      'login.username': '用户名',
      'login.username.hint': '请输入用户名',
      'login.password': '密码',
      'login.password.hint': '请输入密码',
      'login.confirm_password': '确认密码',
      'login.confirm_password.hint': '请输入确认密码',

      'profile.title': '我的',
      'profile.anonymous': '未登录',
      'profile.logout': '退出登录',
      'profile.login': '登录',
      'profile.member_card.title': '我的账户',
      'profile.member_card.btn.recharge': '充值',
      'profile.member_card.remaining_tokens': '剩余积分',
      'profile.member_card.vip_end': '会员到期时间',

      // 发送机器人消息页面
      'chat_detail.title': '发送机器人消息',
      'chat_detail.hint_text': '请输入消息内容',
      'chat_detail.load_more_message': '加载更多消息',
      'chat_detail.no_more_message': '没有更多消息了',
      'chat_detail.has_new_message': '{count} 条新消息',
      'chat_detail.send_message': '按住 说话',

      // 未登录页面
      'need_login.tip': '需要登录',
      'need_login.btn.login': '去登录',

      'no_data': '暂无数据',
    },
    'en_US': {
      // 页面
      'tab.home': 'Home',
      'tab.chat': 'Chat',
      'tab.role': 'Role',
      'tab.profile': 'Profile',

      'tab_role.title': 'Role',

      'tab_chat.title': 'Chat List',

      'edit_role.title': 'Edit Role',
      'add_role.title': 'Add Role',
      'add_role.name': 'Name',
      'add_role.name.hint': 'Please enter the role name',
      'add_role.description': 'Description',
      'add_role.description.hint': 'Please enter the role description',
      'add_role.icon': 'Icon',
      'add_role.icon.hint': 'Please select the icon',
      'add_role.success': 'Role added successfully',
      'add_role.error': 'Role added failed',
      'edit_role.success': 'Role edited successfully',
      'edit_role.error': 'Role edited failed',

      'role_detail.title': 'Role Detail',
      'role_detail.base_info': 'Base Info',
      'role_detail.attachments': 'Attachments',
      'role_detail.no_attachments.tip': 'No attachments',
      'role_detail.chat': 'Chat',
      'role_detail.authorName': 'Author',
      'role_detail.btn_chat': 'Start Chat',
      'role_detail.btn_fork': 'Add to my role library',
      'role_detail.btn_unfork': 'Remove from my role library',
      'role_detail.btn_add_role': 'Add Role',
      'role_detail.add_role.success': 'Add Success',
      'role_detail.add_role.failed': 'Add Failed',
      'role_detail.delete_role.success': 'Delete Success',
      'role_detail.delete_role.failed': 'Delete Failed',

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

      'login.login.title': 'Login',
      'login.login.btn': 'Login',
      'login.login.success': 'Login Success',
      'login.login.error.username_not_exist': 'Username not exist',
      'login.login.error.password_error': 'Password error',
      'login.login.error.unknown': 'Login failed, please try again later',
      'login.register.title': 'Register',
      'login.register.btn': 'Register',
      'login.register.success': 'Register Success',
      'login.register.error.unknown': 'Register failed, please try again later',
      'login.valid.username.can_not_empty': 'Username cannot be empty',
      'login.valid.password.can_not_empty': 'Password cannot be empty',
      'login.valid.confirm_password.can_not_empty':
          'Confirm password cannot be empty',
      'login.valid.confirm_password.not_match': 'Confirm password not match',
      'login.has_account': 'Have an account, go to login',
      'login.no_account': 'No account, go to register',
      'login.username': 'Username',
      'login.username.hint': 'Please enter the username',
      'login.password': 'Password',
      'login.password.hint': 'Please enter the password',
      'login.confirm_password': 'Confirm Password',
      'login.confirm_password.hint': 'Please enter the confirm password',

      'profile.title': 'Profile',
      'profile.anonymous': 'Anonymous',
      'profile.logout': 'Logout',
      'profile.login': 'Login',
      'profile.member_card.title': 'My Account',
      'profile.member_card.btn.recharge': 'Recharge',
      'profile.member_card.remaining_tokens': 'Remaining Credits',
      'profile.member_card.vip_end': 'VIP End Time',

      // 发送机器人消息页面
      'chat_detail.title': 'Send Robot Message',
      'chat_detail.hint_text': 'Please enter the message content',
      'chat_detail.load_more_message': 'Load More Message',
      'chat_detail.no_more_message': 'No More Message',
      'chat_detail.has_new_message': '{count} New Message',
      'chat_detail.send_message': 'Hold to Speak',

      // 未登录页面
      'need_login.tip': 'Need Login',
      'need_login.btn.login': 'Go Login',

      'no_data': 'No Data',
    },
  };
}
