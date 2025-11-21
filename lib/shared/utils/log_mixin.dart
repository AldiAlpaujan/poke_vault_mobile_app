import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

mixin LogMixin {
  final _logger = Logger(
    printer: PrettyPrinter(
      stackTraceBeginIndex: 0,
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 70,
      colors: true,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  void logReq(String title, [dynamic params, dynamic data]) {
    _logger.d('REQUEST $title');
    if (params != null && params.toString() != '{}') {
      _logger.t('Query - $params');
    }
    if (data != null) {
      if (data is FormData) {
        data = data.fields;
      }
      _logger.t('Data - $data');
    }
  }

  void logResponseGet(dynamic log, [String? title]) {
    _logger.d('RESPONSE GET - $title');
    _logger.i(log);
  }

  void logResponsePost(dynamic log, [String? title]) {
    _logger.d('RESPONSE POST - $title');
    _logger.w(log);
  }

  void logResponsePut(dynamic log, [String? title]) {
    _logger.d('RESPONSE PUT - $title');
    _logger.i(log);
  }

  void logResponseDelete(dynamic log, [String? title]) {
    _logger.d('RESPONSE DELETE - $title');
    _logger.w(log);
  }

  void logError(dynamic log, [String? title]) {
    _logger.d('RESPONSE KESALAHAN - $title');
    _logger.e(log);
  }

  void log(dynamic log) {
    _logger.f(log);
  }
}
