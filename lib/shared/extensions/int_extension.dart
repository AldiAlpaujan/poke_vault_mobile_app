extension IntExt on int {
  Duration get seconds => Duration(seconds: this);

  Duration get millis => Duration(milliseconds: this);
}

extension NullableIntExt on int? {
  int get val => this ?? 0;
}
