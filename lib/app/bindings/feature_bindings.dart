import 'package:get/get_instance/get_instance.dart';
import 'package:flutter_project_template/app/bindings/feature_bindings/products_bindings.dart';

class FeatureBindings extends Bindings {
  @override
  void dependencies() {
    ProductsBindings().dependencies();
  }
}
