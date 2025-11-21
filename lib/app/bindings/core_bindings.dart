import 'package:flutter_project_template/config/network/dio_config.dart';
import 'package:flutter_project_template/shared/utils/modal_helpers.dart';
import 'package:flutter_project_template/shared/utils/session.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class CoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => initDio(), fenix: true);
    Get.lazyPut(() => Session(), fenix: true);
    Get.lazyPut(() => ModalHelper(), fenix: true);
  }
}
