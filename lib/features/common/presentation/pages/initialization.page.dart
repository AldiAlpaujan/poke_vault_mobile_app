import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/routes/pages.dart';
import 'package:flutter_project_template/shared/services/cloud_messaging_service.dart';
import 'package:flutter_project_template/shared/services/notification_service.dart';
import 'package:flutter_project_template/shared/utils/responsive.dart';
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
    Get.offAllNamed(Routes.products);
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
