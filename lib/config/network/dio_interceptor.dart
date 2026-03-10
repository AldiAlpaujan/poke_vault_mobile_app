import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:poke_vault_mobile_app/shared/utils/function.dart';
import 'package:poke_vault_mobile_app/shared/utils/log_mixin.dart';
import 'package:poke_vault_mobile_app/shared/utils/main_helpers.dart';

class DioInterceptor extends Interceptor with LogMixin {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await session.loadUserToken();

    if (kDebugMode) print('TOKEN - $token');

    if (token == '') {
      options.headers['Authorization'] = 'Bearer $token';
    }

    logReq(
      '${options.method} ${options.path}',
      options.queryParameters,
      options.data,
    );

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final isWrap = response.data['isWrap'] == true;

    if (!isWrap) {
      final data = response.data;
      int? count = data['count'];
      dynamic results = data['results'];

      response.data = {
        'isWrap': true,
        'code': response.statusCode ?? 200,
        if (count != null) 'count': count,
        'data': results ?? response.data,
      };
    }

    switch (response.requestOptions.method) {
      case 'GET':
        logResponseGet(response.data, response.requestOptions.path);
        break;
      case 'POST':
        logResponsePost(response.data, response.requestOptions.path);
        break;
      case 'PUT':
        logResponsePut(response.data, response.requestOptions.path);
        break;
      case 'DELETE':
        logResponseDelete(response.data, response.requestOptions.path);
        break;
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    var errMsg = err.message;

    // logging
    if (kDebugMode) print(err);

    logError(response, err.requestOptions.path);
    logError(err, "Dio Exception");

    // check internet connection
    if (err.type == DioExceptionType.connectionError) {
      errMsg = "Ups! Gagal mengirim permintaan. Periksa koneksi internet Anda.";
    }

    // timeout
    if (err.type == DioExceptionType.connectionTimeout) {
      errMsg = "Ups! Ada masalah. Permintaan membutuhkan waktu terlalu lama.";
    }

    switch (response?.statusCode) {
      case HttpStatus.unauthorized:
        Func.clearSession();
        break;
      case HttpStatus.badRequest:
        final data = response?.data;
        final errorDetail = data['errorDetail'];
        if (errorDetail == "bad_model_request") {
          errMsg = 'Tidak dapat mengirim permintaan';
        } else {
          errMsg = data["errorData"];
        }
        break;
      case HttpStatus.internalServerError:
        errMsg = 'Tidak dapat mengirim permintaan';
        break;
    }

    handler.next(err.copyWith(message: errMsg));
  }
}
