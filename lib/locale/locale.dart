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

      'add_role.title': '添加角色',
      'add_role.name': '角色名称',
      'add_role.name.hint': '请输入角色名称',
      'add_role.description': '角色描述',
      'add_role.description.hint': '请输入角色描述',
      'add_role.icon': '角色图标',
      'add_role.success': '角色添加成功',
      'add_role.error': '角色添加失败',

      'btn.cancel': '取消',
      'btn.save': '保存',

      'snackbar.title': '提示',

      'language': 'zh_CN',
      'language.short': 'zh',

      'no_more_data': '没有更多数据了',
    },
    'en_US': {
      // 页面
      'tab.home': 'Home',
      'tab.chat': 'Chat',
      'tab.role': 'Role',
      'tab.profile': 'Profile',

      'tab_role.title': 'Role',

      'add_role.title': 'Add Role',
      'add_role.name': 'Name',
      'add_role.name.hint': 'Please enter the role name',
      'add_role.description': 'Description',
      'add_role.description.hint': 'Please enter the role description',
      'add_role.icon': 'Icon',
      'add_role.success': 'Role added successfully',
      'add_role.error': 'Role added failed',

      'btn.cancel': 'Cancel',
      'btn.save': 'Save',

      'snackbar.title': 'Hint',

      'language': 'en_US',
      'language.short': 'en',

      'no_more_data': 'No more data',
    },
  };
}
