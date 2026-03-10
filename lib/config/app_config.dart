import 'package:poke_vault_mobile_app/shared/enums/app_flavor.dart';

class AppConfig {
  final AppFlavor flavor;
  final String appName;
  final String apiUrl;

  AppConfig({
    required this.flavor,
    required this.appName,
    required this.apiUrl,
  });
}
