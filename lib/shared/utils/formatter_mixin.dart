import 'package:intl/intl.dart';

mixin FormatterMixin {
  String percentFormatter(double data) {
    String formattedNumber = data.toStringAsFixed(2);
    formattedNumber = formattedNumber.replaceAll(RegExp(r"0*$"), "");
    final lastChar = formattedNumber[formattedNumber.length - 1];
    if (lastChar == '.') {
      formattedNumber = formattedNumber.substring(
        0,
        formattedNumber.length - 1,
      );
    }
    return formattedNumber;
  }

  String doubleFormatter(double data) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    String s = data.toString().replaceAll(regex, '');
    return s;
  }

  String dateFormatUI(DateTime date, {String? format}) {
    return DateFormat(format ?? "dd/MM/yyyy", 'id').format(date);
  }

  String moneyFormatter(double money, {bool withRp = true}) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: withRp ? "Rp " : "",
      decimalDigits: 0,
    ).format(money);
  }

  String numberFormatter(double money) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: "",
      decimalDigits: 0,
    ).format(money);
  }
}
