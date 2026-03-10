import 'package:poke_vault_mobile_app/features/common/widget/app_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/shared/constants/gen/assets.gen.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? color;
  const AppBackButton({super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? Get.back,
      icon: AppSvgIcon(svg: Assets.svg.arrowLeft, color: color ?? Colors.white),
    );
  }
}
