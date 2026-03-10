import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/app/bindings/app_bindings.dart';
import 'package:poke_vault_mobile_app/app/routes/pages.dart';
import 'package:poke_vault_mobile_app/config/app_config.dart';
import 'package:poke_vault_mobile_app/config/network/isrg_patch.dart';
import 'package:poke_vault_mobile_app/config/theme/theme.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_banner.dart';
import 'package:poke_vault_mobile_app/shared/enums/app_flavor.dart';
import 'package:poke_vault_mobile_app/shared/services/notification_service.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:poke_vault_mobile_app/shared/services/object_box_service.dart';

Future<void> bootstrap() async {
  applyIsrgPatch();
  WidgetsFlutterBinding.ensureInitialized();
  AppBindings().dependencies();
  await ObjectBoxService.init();
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
    final appConifg = Get.find<AppConfig>();
    final application = GetMaterialApp(
      title: appConifg.appName,
      getPages: AppPages.pages,
      initialRoute: AppPages.initial,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppTheme.localizationsDelegates,
      supportedLocales: AppTheme.supportedLocales,
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

    return switch (appConifg.flavor) {
      AppFlavor.development => AppBanner(message: 'DEV', child: application),
      AppFlavor.production => application,
    };
  }
}
