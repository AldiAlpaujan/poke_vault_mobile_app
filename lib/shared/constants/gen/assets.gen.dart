// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/README.md
  String get readme => 'assets/audio/README.md';

  /// List of all assets
  List<String> get values => [readme];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/README.md
  String get readme => 'assets/fonts/README.md';

  /// List of all assets
  List<String> get values => [readme];
}

class $AssetsHtmlGen {
  const $AssetsHtmlGen();

  /// File path: assets/html/README.md
  String get readme => 'assets/html/README.md';

  /// List of all assets
  List<String> get values => [readme];
}

class $AssetsIllustrationGen {
  const $AssetsIllustrationGen();

  /// File path: assets/illustration/README.md
  String get readme => 'assets/illustration/README.md';

  /// List of all assets
  List<String> get values => [readme];
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/README.md
  String get readme => 'assets/image/README.md';

  /// File path: assets/image/img-error.jpg
  AssetGenImage get imgError =>
      const AssetGenImage('assets/image/img-error.jpg');

  /// List of all assets
  List<dynamic> get values => [readme, imgError];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/README.md
  String get readme => 'assets/svg/README.md';

  /// File path: assets/svg/arrow-left.svg
  String get arrowLeft => 'assets/svg/arrow-left.svg';

  /// File path: assets/svg/search-normal.svg
  String get searchNormal => 'assets/svg/search-normal.svg';

  /// List of all assets
  List<String> get values => [readme, arrowLeft, searchNormal];
}

class Assets {
  const Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsHtmlGen html = $AssetsHtmlGen();
  static const $AssetsIllustrationGen illustration = $AssetsIllustrationGen();
  static const $AssetsImageGen image = $AssetsImageGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
