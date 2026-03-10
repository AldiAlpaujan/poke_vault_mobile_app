import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:poke_vault_mobile_app/features/common/presentation/pages/initialization.page.dart';

// poke_vault_mobile_app
import 'package:poke_vault_mobile_app/features/pokemon/presentation/pages/pokemon_list.page.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/pages/pokemon_detail.page.dart';

part 'routes.dart';

/// This class is a configuration of all routes in the application.
/// so the router will be directed to the page
class AppPages {
  static String initial = Routes.initialization;

  static final pages = <GetPage>[
    GetPage(
      name: Routes.initialization,
      page: () => const InitializationPage(),
    ),
    GetPage(name: Routes.pokemonList, page: () => const PokemonListPage()),
    GetPage(name: Routes.pokemonDetail, page: () => const PokemonDetailPage()),
  ];
}
