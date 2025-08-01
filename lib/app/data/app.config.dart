// ignore_for_file: non_constant_identifier_names

import 'package:astrum/app/modules/chat/views/chat_view.dart';
import 'package:astrum/app/modules/discovery/views/discovery_view.dart';
import 'package:astrum/app/modules/profile/views/profile_view.dart';
import 'package:astrum/types/types.dart';

List tabs = [
  {
    "icon": "assets/svgs/tab_home_unselected.svg",
    "icon_selected": "assets/svgs/tab_home_selected.svg",
    "label": 'tab.home',
    "name": TabName.home,
    "page": const DiscoveryView(),
  },
  {
    "icon": "assets/svgs/tab_chat_unselected.svg",
    "icon_selected": "assets/svgs/tab_chat_selected.svg",
    "label": 'tab.chat',
    "name": TabName.chat,
    "page": ChatView(),
  },
  {
    "icon": "assets/svgs/tab_profile_unselected.svg",
    "icon_selected": "assets/svgs/tab_profile_selected.svg",
    "label": 'tab.profile',
    "name": TabName.profile,
    "page": const ProfileView(),
  },
];

List<Map<String, String>> languages = [
  {"label": "简体中文", "name": "profile.language.zh_CN", "value": "zh_CN"},
  {"label": "English", "name": "profile.language.en_US", "value": "en_US"},
];

String LocalLanguageKey = 'current-language';
