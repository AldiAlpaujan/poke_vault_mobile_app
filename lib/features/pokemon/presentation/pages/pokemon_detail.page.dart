import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_list_error.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_loading.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/controllers/pokemon_detail.controller.dart';
import 'package:get/get.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/widgets/pokemon_detail_header.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/widgets/pokemon_state.dart';

class PokemonDetailPage extends GetView<PokemonDetailController> {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading) return const AppLoading();
        if (controller.isError || controller.detail == null) {
          return AppListError(onRefresh: controller.getData);
        }

        return ListView(
          padding: EdgeInsets.zero,
          children: [PokemonDetailHeader(), PokemonState()],
        );
      }),
    );
  }
}
