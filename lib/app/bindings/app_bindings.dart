import 'package:flutter_project_template/app/bindings/core_bindings.dart';
import 'package:flutter_project_template/app/bindings/feature_bindings.dart';
import 'package:get/get_instance/get_instance.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    CoreBindings().dependencies();
    FeatureBindings().dependencies();
  }
}
