import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/controllers/pokemon_detail.controller.dart';
import 'package:get/get.dart';

class PokemonDetailPage extends GetView<PokemonDetailController> {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('pokemon_detail')),
      body: const Center(child: Text('pokemon_detail')),
    );
  }
}
