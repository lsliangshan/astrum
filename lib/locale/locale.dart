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

      'language': 'zh_CN',
      'language.short': 'zh',
    },
    'en_US': {
      // 页面
      'tab.home': 'Home',
      'tab.chat': 'Chat',
      'tab.role': 'Role',
      'tab.profile': 'Profile',

      'language': 'en_US',
      'language.short': 'en',
    },
  };
}
