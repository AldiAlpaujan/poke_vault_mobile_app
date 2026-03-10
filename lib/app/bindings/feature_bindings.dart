import 'package:get/get_instance/get_instance.dart';
import 'package:poke_vault_mobile_app/app/bindings/feature_bindings/products_bindings.dart';

class FeatureBindings extends Bindings {
  @override
  void dependencies() {
    ProductsBindings().dependencies();
  }
}
