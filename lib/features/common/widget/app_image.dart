import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/shared/enums/e_image_type.dart';

import '../../../shared/constants/gen/assets.gen.dart';

class AppImage extends StatelessWidget {
  final String url;
  final EImageType type;
  final File? file;
  final String? alt;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BoxFit? imgHandlingfit;
  final Color? color;
  final BorderRadiusGeometry borderRadius;
  const AppImage({
    super.key,
    required this.url,
    this.type = EImageType.network,
    this.alt,
    this.file,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.imgHandlingfit,
    this.borderRadius = BorderRadius.zero,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: borderRadius, child: image());
  }

  Widget image() {
    if (file != null) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (_, _, _) => errorImg(),
      );
    }
    if (type.isNetwork) {
      return CachedNetworkImage(
        fit: fit,
        imageUrl: url,
        height: height,
        width: width,
        color: color,
        colorBlendMode: BlendMode.srcIn,
        placeholder: (context, url) => errorImg(),
        errorListener: (err) {
          if (kDebugMode) {
            print("IMG ERROR ${err.toString().split('uri = ')[1]}");
          }
        },
        errorWidget: (context, url, error) => errorImg(),
      );
    } else {
      return Image.asset(
        url,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (_, _, _) => errorImg(),
      );
    }
  }

  Widget errorImg() {
    return Image.asset(
      alt ?? Assets.image.imgError,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
