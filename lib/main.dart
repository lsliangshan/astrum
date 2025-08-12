import 'dart:ui';
import 'package:astrum/database/daos/message.dao.dart';
import 'package:astrum/database/daos/user.dao.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/services/attachment.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/message.dart';
import 'package:astrum/services/role.dart';
import 'package:astrum/services/toast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/locale/locale.dart';
import 'package:astrum/services/localstorage.dart';
import 'package:astrum/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initServices();

  LocalstorageService localstorageService = LocalstorageService();
  String? localLanguage = await localstorageService.getString(LocalLanguageKey);
  if (localLanguage == null || localLanguage.isEmpty) {
    localLanguage = PlatformDispatcher.instance.locale.languageCode == 'zh'
        ? 'zh_CN'
        : 'en_US';

    await localstorageService.setString(LocalLanguageKey, localLanguage);
  }
  Locale locale = Locale(
    localLanguage.split('_')[0],
    localLanguage.split('_')[1],
  );

  initializeDateFormatting().then(
    (_) => runApp(
      GetMaterialApp(
        title: "astrum",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        translations: Messages(),
        locale: locale,
        fallbackLocale: const Locale('en', 'US'),
        theme: darkTheme(),
        themeMode: ThemeMode.light,
        defaultTransition: Transition.rightToLeft,
      ),
    ),
  );
}

Future<void> initServices() async {
  LocalstorageService localstorageService = LocalstorageService();
  Get.lazyPut(() => localstorageService);

  ToastService toastService = ToastService();
  Get.lazyPut(() => toastService);

  AppDatabase db = AppDatabase();
  UserDao userDao = UserDao(db);
  Get.put<UserDao>(userDao);

  MessageDao messageDao = MessageDao(db);
  Get.put<MessageDao>(messageDao);

  AttachmentService attachmentService = AttachmentService();
  Get.lazyPut(() => attachmentService);

  RoleService roleService = RoleService();
  Get.lazyPut(() => roleService);

  MessageService messageService = MessageService();
  Get.lazyPut(() => messageService);

  AuthService authService = AuthService();
  Get.lazyPut(() => authService);
}
