import 'package:poke_vault_mobile_app/bootstrap.dart';
import 'package:poke_vault_mobile_app/config/app_config.dart';
import 'package:poke_vault_mobile_app/shared/enums/app_flavor.dart';
import 'package:get/instance_manager.dart';

void main() {
  Get.put(
    AppConfig(
      flavor: AppFlavor.production,
      appName: "Poké Vault",
      apiUrl: "https://aldimalpaujanbackend-production.up.railway.app/api",
    ),
  );
  bootstrap();
}
