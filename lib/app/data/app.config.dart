// ignore_for_file: non_constant_identifier_names

import 'package:astrum/app/modules/chat/views/chat_view.dart';
import 'package:astrum/app/modules/discovery/views/discovery_view.dart';
import 'package:astrum/app/modules/profile/views/profile_view.dart';
import 'package:astrum/app/modules/role/views/role_view.dart';
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
    "icon": "assets/svgs/tab_role_unselected.svg",
    "icon_selected": "assets/svgs/tab_role_selected.svg",
    "label": 'tab.role',
    "name": TabName.role,
    "page": const RoleView(),
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

String ServiceAgreementUrl =
    'https://apipilot.liangqy.com/astrum/member/service/aggrement?lang={LANG}';
String ServiceFaqUrl =
    'https://apipilot.liangqy.com/astrum/member/service/faq?lang={LANG}';

String ServiceTermsUrl =
    'https://apipilot.liangqy.com/astrum/member/terms?lang={LANG}';

String ServiceAutoRenewalUrl =
    'https://apipilot.liangqy.com/astrum/member/renewal?lang={LANG}';

String ServicePrivacyUrl =
    'https://apipilot.liangqy.com/astrum/member/privacy?lang={LANG}';

// 会员特权
List<Map<String, String>> memberPrivileges = [
  {
    "icon": "assets/svgs/massive_volume.svg",
    "title": "member.privilege.massive.volume",
    "tip": "member.privilege.massive.volume.tip",
  },
  {
    "icon": "assets/svgs/unlimited_creation.svg",
    "title": "member.privilege.unlimited.creation",
    "tip": "member.privilege.unlimited.creation.tip",
  },
  {
    "icon": "assets/svgs/deep_knowledge.svg",
    "title": "member.privilege.deep.knowledge",
    "tip": "member.privilege.deep.knowledge.tip",
  },
  {
    "icon": "assets/svgs/exclusive_access.svg",
    "title": "member.privilege.exclusive.access",
    "tip": "member.privilege.exclusive.access.tip",
  },
  {
    "icon": "assets/svgs/early_access.svg",
    "title": "member.privilege.early.access",
    "tip": "member.privilege.early.access.tip",
  },
  {
    "icon": "assets/svgs/priority_support.svg",
    "title": "member.privilege.priority.support",
    "tip": "member.privilege.priority.support.tip",
  },
];
