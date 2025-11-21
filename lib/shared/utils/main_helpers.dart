import 'package:dio/dio.dart';
import 'package:flutter_project_template/shared/utils/modal_helpers.dart';
import 'package:flutter_project_template/shared/utils/session.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_core/src/get_main.dart';

final dio = Get.find<Dio>();
final session = Get.find<Session>();
final modalHelper = Get.find<ModalHelper>();
