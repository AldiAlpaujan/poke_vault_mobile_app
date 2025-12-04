import 'package:flutter_project_template/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

import 'dio_interceptor.dart';

Dio initDio() {
  return Dio(
    BaseOptions(
      baseUrl: Get.find<AppConfig>().apiUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
      followRedirects: false,
    ),
  )..interceptors.add(DioInterceptor());
}
