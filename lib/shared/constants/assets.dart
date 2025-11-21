class Assets {
  static final html = _Html();
  static final svg = _Svg();
  static final image = _Image();
  static final illustration = _Illustration();
}

class _Html {}

class _Svg {
  final magnify = 'assets/svg/search-normal.svg';
  final arrowLeft = 'assets/svg/arrow-left.svg';
  final close = 'assets/svg/close.svg';
}

class _Image {
  final errorImg = 'assets/image/img-error.jpg';
}

class _Illustration {}
