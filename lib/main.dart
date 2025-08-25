import 'dart:io';
import 'dart:ui';
import 'package:astrum/database/daos/message.dao.dart';
import 'package:astrum/database/daos/role.dao.dart';
import 'package:astrum/database/daos/user.dao.dart';
import 'package:astrum/database/database.dart';
import 'package:astrum/services/attachment.dart';
import 'package:astrum/services/auth.dart';
import 'package:astrum/services/message.dart';
import 'package:astrum/services/role.dart';
import 'package:astrum/services/toast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:astrum/app/data/app.config.dart';
import 'package:astrum/locale/locale.dart';
import 'package:astrum/services/localstorage.dart';
import 'package:astrum/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

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

  HttpOverrides.global = MyHttpOverrides();

  await dotenv.load(fileName: ".env");

  // await Supabase.initialize(
  //   url: dotenv.env['SUPABASE_URL']!,
  //   anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  // );

  initializeDateFormatting().then(
    (_) => runApp(
      GetMaterialApp(
        title: "灵枢",
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

  RoleDao roleDao = RoleDao(db);
  Get.put<RoleDao>(roleDao);

  MessageDao messageDao = MessageDao(db);
  Get.put<MessageDao>(messageDao);

  AttachmentService attachmentService = AttachmentService();
  Get.lazyPut(() => attachmentService);

  MessageService messageService = MessageService();
  Get.lazyPut(() => messageService);

  AuthService authService = AuthService();
  Get.lazyPut(() => authService);

  RoleService roleService = RoleService();
  Get.lazyPut(() => roleService);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
