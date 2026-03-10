import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_image.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_svg_icon.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/controllers/pokemon_detail.controller.dart';
import 'package:get/get.dart';
import 'package:poke_vault_mobile_app/shared/constants/gen/assets.gen.dart';
import 'package:poke_vault_mobile_app/shared/extensions/extensions.dart';
import 'package:poke_vault_mobile_app/shared/utils/widget_extenstion.dart';

const typeColors = {
  'fire': Color(0xFFFF6B35),
  'water': Color(0xFF4FC3F7),
  'grass': Color(0xFF81C784),
  'electric': Color(0xFFFFD54F),
  'psychic': Color(0xFFF06292),
  'ice': Color(0xFF80DEEA),
  'dragon': Color(0xFF7E57C2),
  'dark': Color(0xFF546E7A),
  'fairy': Color(0xFFF48FB1),
  'normal': Color(0xFFBCAAA4),
  'fighting': Color(0xFFFF8A65),
  'flying': Color(0xFF90CAF9),
  'poison': Color(0xFFCE93D8),
  'ground': Color(0xFFFFCC80),
  'rock': Color(0xFFBCAAA4),
  'bug': Color(0xFFAED581),
  'ghost': Color(0xFF9575CD),
  'steel': Color(0xFF90A4AE),
};

class PokemonDetailHeader extends GetView<PokemonDetailController> {
  const PokemonDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemon = controller.detail!;
    final primaryType = pokemon.types?.first.type?.name ?? 'normal';
    final bgColor = typeColors[primaryType] ?? Colors.grey;

    return Container(
      color: bgColor,
      width: double.infinity,
      height: 360,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            bottom: -10,
            child: AppSvgIcon(
              svg: Assets.svg.pokeBall,
              size: 180,
              color: Colors.white.withValues(alpha: .2),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AppImage(
              url: pokemon.officialArtwork.val(),
              alt: Assets.image.pokeBallPlaceholder,
              height: 220,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: AppSvgIcon(
                        svg: Assets.svg.arrowLeft,
                        color: Colors.white,
                      ),
                    ).onTap(Get.back),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 30,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.favorite_outline,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).b(10),
                Text(
                  pokemon.name?.capitalize ?? '-',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ).b(4),
                Row(
                  spacing: 4,
                  children: [
                    ...(pokemon.types ?? []).map(
                      (e) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white.withValues(alpha: .2),
                        ),
                        child: Text(
                          e.type?.name?.capitalize ?? '-',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
