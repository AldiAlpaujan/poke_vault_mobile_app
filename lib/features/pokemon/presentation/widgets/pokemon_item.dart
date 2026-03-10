import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_image.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_svg_icon.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_res.dart';
import 'package:get/get.dart';
import 'package:poke_vault_mobile_app/shared/constants/gen/assets.gen.dart';
import 'package:poke_vault_mobile_app/shared/extensions/extensions.dart';
import 'package:poke_vault_mobile_app/shared/utils/widget_extenstion.dart';

class PokemonItem extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    bottom: -30,
                    child: AppSvgIcon(
                      svg: Assets.svg.pokeBall,
                      size: 120,
                      color: Color(0xFFAAB2C5).withValues(alpha: .2),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      spacing: 0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          pokemon.name?.capitalizeFirst ?? '-',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "pokemon id - ${pokemon.id.val}",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ).all(12),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: AppImage(
              height: 130,
              url: pokemon.officialArtwork.val(),
              alt: Assets.image.pokeBallPlaceholder,
            ),
          ),
        ],
      ),
    );
  }
}
