import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/app/routes/pages.dart';
import 'package:poke_vault_mobile_app/features/common/presentation/views/app_data_list_view.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/controllers/pokemon_list.controller.dart';
import 'package:get/get.dart';

class PokemonListPage extends GetView<PokemonListController> {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('pokemon_list')),
      body: AppDataListView(
        noData: controller.noData,
        isError: controller.isError,
        isLoading: controller.isLoading,
        emptyData: controller.data.isEmpty,
        refreshData: () => controller.refreshData(),
        loadData: () => controller.loadData(),
        children: [
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.pokemonDetail),
            child: Text("Detail"),
          ),
        ],
      ),
    );
  }
}
