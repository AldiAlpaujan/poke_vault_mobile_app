extension StringExt on String {
  bool minLen(int len) => length >= len;
}

extension NullableStringExt on String? {
  String val([String replacer = '-']) => this ?? replacer;
}
