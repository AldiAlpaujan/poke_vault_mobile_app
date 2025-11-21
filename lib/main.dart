import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/bindings/app_bindings.dart';
import 'package:flutter_project_template/app/routes/pages.dart';
import 'package:flutter_project_template/config/network/isrg_patch.dart';
import 'package:flutter_project_template/config/theme/theme.dart';
import 'package:flutter_project_template/shared/services/notification_service.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:in_app_update/in_app_update.dart';

void main() {
  applyIsrgPatch();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> setupInteractedMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen(
      NotificationService.handleInteractionOnBackground,
    );
  }

  Future<void> _checkAppUpdate() async {
    try {
      var updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    _checkAppUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      getPages: AppPages.pages,
      initialRoute: AppPages.initial,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppTheme.localizationsDelegates,
      supportedLocales: AppTheme.supportedLocales,
      initialBinding: AppBindings(),
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: AppTheme.primarySwatch,
        fontFamily: AppTheme.fontFamily,
        colorScheme: AppTheme.colorScheme,
        primaryColor: AppTheme.primaryColor,
        elevatedButtonTheme: AppTheme.btnTheme,
        scaffoldBackgroundColor: AppTheme.bgColor,
        floatingActionButtonTheme: AppTheme.floatBtnTheme,
        appBarTheme: AppTheme.appBarTheme,
      ),
    );
  }
}
