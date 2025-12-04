import 'package:flutter_project_template/app/bindings/core_bindings.dart';
import 'package:flutter_project_template/app/bindings/feature_bindings.dart';
import 'package:get/get_instance/get_instance.dart';

class AppBindings extends Bindings {
  static final appConfigDependencies = <Function>[];

  static void registerAppConfig(Function dependency) {
    appConfigDependencies.add(dependency);
  }

  @override
  void dependencies() {
    for (Function dependency in appConfigDependencies) {
      dependency();
    }
    CoreBindings().dependencies();
    FeatureBindings().dependencies();
  }
}
