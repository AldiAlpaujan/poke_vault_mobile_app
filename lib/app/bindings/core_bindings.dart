import 'package:poke_vault_mobile_app/config/network/dio_config.dart';
import 'package:poke_vault_mobile_app/shared/utils/modal_helpers.dart';
import 'package:poke_vault_mobile_app/shared/utils/session.dart';
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
