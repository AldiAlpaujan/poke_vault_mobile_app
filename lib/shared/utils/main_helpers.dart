import 'package:dio/dio.dart';
import 'package:poke_vault_mobile_app/shared/utils/modal_helpers.dart';
import 'package:poke_vault_mobile_app/shared/utils/session.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_core/src/get_main.dart';

final dio = Get.find<Dio>();
final session = Get.find<Session>();
final modalHelper = Get.find<ModalHelper>();
