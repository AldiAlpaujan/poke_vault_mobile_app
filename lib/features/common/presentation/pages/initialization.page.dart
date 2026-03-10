import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/app/routes/pages.dart';
import 'package:poke_vault_mobile_app/shared/services/cloud_messaging_service.dart';
import 'package:poke_vault_mobile_app/shared/services/notification_service.dart';
import 'package:poke_vault_mobile_app/shared/utils/responsive.dart';
import 'package:get/get.dart';

class InitializationPage extends StatefulWidget {
  const InitializationPage({super.key});

  @override
  State<InitializationPage> createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  Future initialize() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    NotificationService.initNotification();
    CloudMessagingService.initializeMessaging();
    Get.offAllNamed(Routes.pokemonList);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.getDevice();
    return const Scaffold();
  }
}
