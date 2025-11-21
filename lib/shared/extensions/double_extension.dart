extension NullableDoubleExt on double? {
  double get val => this ?? 0;
}
