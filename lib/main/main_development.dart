import 'package:flutter_project_template/app/bindings/app_bindings.dart';
import 'package:flutter_project_template/bootstrap.dart';
import 'package:flutter_project_template/config/app_config.dart';
import 'package:flutter_project_template/shared/enums/app_flavor.dart';
import 'package:get/instance_manager.dart';

void main() {
  AppBindings.registerAppConfig(
    () => Get.put(
      AppConfig(
        flavor: AppFlavor.development,
        appName: "Project Template",
        apiUrl: "https://aldimalpaujanbackend-production.up.railway.app/api",
      ),
    ),
  );
  bootstrap();
}
