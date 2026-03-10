import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/app/routes/pages.dart';
import 'package:poke_vault_mobile_app/features/common/presentation/views/app_data_list_view.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_bar_search.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_grid_menu.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/controllers/pokemon_list.controller.dart';
import 'package:get/get.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/widgets/pokemon_item.dart';
import 'package:poke_vault_mobile_app/shared/utils/widget_extenstion.dart';

class PokemonListPage extends GetView<PokemonListController> {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        title: "Poké Vault",
        hintText: 'Pencarian...',
        withLeading: false,
        onChanged: (v) => controller.search(v),
      ),

      body: Obx(
        () => AppDataListView(
          noData: controller.noData,
          isError: controller.isError,
          isLoading: controller.isLoading,
          emptyData: controller.data.isEmpty,
          refreshData: () => controller.refreshData(),
          loadData: () => controller.loadData(),
          listBuilder: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: AppGridMenu(
              columnCount: 2,
              items: [
                ...controller.data.map(
                  (item) => PokemonItem(pokemon: item).onTap(
                    () => Get.toNamed(Routes.pokemonDetail, arguments: item),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
