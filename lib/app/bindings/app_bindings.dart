import 'package:poke_vault_mobile_app/app/bindings/core_bindings.dart';
import 'package:poke_vault_mobile_app/app/bindings/feature_bindings.dart';
import 'package:get/get_instance/get_instance.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    CoreBindings().dependencies();
    FeatureBindings().dependencies();
  }
}
