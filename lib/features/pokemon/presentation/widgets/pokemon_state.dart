import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/controllers/pokemon_detail.controller.dart';
import 'package:get/get.dart';
import 'package:poke_vault_mobile_app/shared/utils/widget_extenstion.dart';

class PokemonState extends GetView<PokemonDetailController> {
  const PokemonState({super.key});

  static const _statLabels = {
    'hp': 'HP',
    'attack': 'Attack',
    'defense': 'Defense',
    'special-attack': 'Sp. Atk',
    'special-defense': 'Sp. Def',
    'speed': 'Speed',
  };

  static const _statColors = {
    'hp': Colors.red,
    'attack': Colors.orange,
    'defense': Colors.yellow,
    'special-attack': Colors.blue,
    'special-defense': Colors.green,
    'speed': Colors.teal,
  };

  @override
  Widget build(BuildContext context) {
    final stats = controller.detail?.stats ?? [];
    final abilities = controller.detail?.abilities ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleSection("Detail"),
          ...stats.map((s) {
            final label = _statLabels[s.stat?.name] ?? s.stat?.name ?? '';
            final value = s.baseStat ?? 0;
            final color = _statColors[s.stat?.name] ?? Colors.grey;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      label,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 36,
                    child: Text(
                      '$value',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: value / 255,
                        backgroundColor: color.withValues(alpha: 0.2),
                        valueColor: AlwaysStoppedAnimation(color),
                        minHeight: 6,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          titleSection("Abilities").t(10),
          Row(
            spacing: 8,
            children: [
              ...abilities.map(
                (e) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[400]!.withValues(alpha: .2),
                  ),
                  child: Text(
                    e.ability?.name?.capitalize ?? '-',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        Container(
          width: 32,
          height: 4,
          margin: EdgeInsets.only(left: 1, top: 2, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ],
    );
  }
}
