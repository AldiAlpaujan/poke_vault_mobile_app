import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/shared/constants/gen/assets.gen.dart';
import 'package:poke_vault_mobile_app/shared/enums/e_image_type.dart';

class AppImage extends StatelessWidget {
  final String url;
  final EImageType type;
  final File? file;
  final String? alt;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BoxFit? imgHandlingfit;
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
      return Image.network(
        url,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (_, _, _) => errorImg(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return errorImg();
          }
        },
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
      alt ?? Assets.image.imgError.path,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
