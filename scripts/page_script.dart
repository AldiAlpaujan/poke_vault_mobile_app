// ignore_for_file: avoid_print
import 'dart:io';

import 'extensions.dart';

Future<void> createPage(
  String pageName,
  String featurePage,
  bool isPagging,
) async {
  final featurePath = 'lib/features/$featurePage';

  final featureDir = Directory(featurePath);
  if (!featureDir.existsSync()) {
    print('📂 ERROR: Feature "$featurePage" does not exist');
    return;
  }

  final pageFile = File('$featurePath/presentation/pages/$pageName.page.dart');
  final controllerFile = File(
    '$featurePath/presentation/controllers/$pageName.controller.dart',
  );

  if (pageFile.existsSync()) {
    print('📄 The $pageName.page already exists');
    return;
  } else {
    await pageFile.create(recursive: true);
  }

  if (controllerFile.existsSync()) {
    print('📄 The $pageName.controller already exists');
    return;
  } else {
    await controllerFile.create(recursive: true);
  }

  late String pageContent, controllerContent;

  if (!isPagging) {
    pageContent =
        '''
import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/features/$featurePage/presentation/controllers/$pageName.controller.dart';
import 'package:get/get.dart';

class ${pageName.toPascalCase()}Page extends GetView<${pageName.toPascalCase()}Controller> {
  const ${pageName.toPascalCase()}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$pageName'),
      ),
      body: const Center(
        child: Text(
          '$pageName',
        )
      ),
    );
  }
}
''';

    controllerContent =
        '''
import 'package:poke_vault_mobile_app/shared/utils/handler_api_mixin.dart';
import 'package:get/get.dart';

class ${pageName.toPascalCase()}Controller extends GetxController with HandlerApiMixin {}
''';
  } else {
    pageContent =
        '''
import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/features/common/presentation/views/app_data_list_view.dart';
import 'package:poke_vault_mobile_app/features/$featurePage/presentation/controllers/$pageName.controller.dart';
import 'package:get/get.dart';

class ${pageName.toPascalCase()}Page extends GetView<${pageName.toPascalCase()}Controller> {
  const ${pageName.toPascalCase()}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$pageName'),
      ),
      body: AppDataListView(
        noData: controller.noData,
        isError: controller.isError,
        isLoading: controller.isLoading,
        emptyData: controller.data.isEmpty,
        refreshData: () => controller.refreshData(),
        loadData: () => controller.loadData(),
        children: const [],
      ),
    );
  }
}
''';

    controllerContent =
        '''
import 'package:poke_vault_mobile_app/config/bases/base_api_pagination.dart';

class ${pageName.toPascalCase()}Controller extends ApiPagination {

  @override
  Future<void> getData({bool isLoad = false, String? keyword}) async {
    // await runRequest(
    //   usecase,
    //   isLoad,
    //   keyword,
    // );
  }

  @override
  Future<void> loadData() async {
    await getData();
  }

  @override
  Future<void> refreshData() {
    return getData(isLoad: true);
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
''';
  }

  await controllerFile.writeAsString(controllerContent);
  await pageFile.writeAsString(pageContent);

  print('📄 $pageName created');
  _addRouteAndPage(featurePage, pageName);
}

void _addRouteAndPage(String featurePage, String pageName) {
  const routerPath = 'lib/app/routes/routes.dart';
  const pagesPath = 'lib/app/routes/pages.dart';
  final routerFile = File(routerPath);
  final pagesFile = File(pagesPath);

  if (!routerFile.existsSync() || !pagesFile.existsSync()) {
    print('🚨 ERROR: One or both files do not exist.');
    return;
  }

  // Read and update router.dart
  final routerContent = routerFile.readAsStringSync();

  // Convert page name to camelCase for variable and kebab-case for URL
  final routeVarName = pageName.toCamelCase();
  final routePath = pageName.replaceAll('_', '-');

  final updatedRoutesContent = routerContent.replaceFirst(
    RegExp(r'}\s*$'), // Cari tanda "}" terakhir di file
    "  static const String $routeVarName = '/$routePath';\n}", // Tambahkan route baru
  );
  routerFile.writeAsStringSync(updatedRoutesContent);

  // Read current pages.dart content
  var pagesContent = pagesFile.readAsStringSync();

  // Check if feature comment already exists
  final featureComment = '// ${featurePage.toPascalCase()}';
  final pageImport =
      "import 'package:poke_vault_mobile_app/features/$featurePage/presentation/pages/$pageName.page.dart';";

  String updatedPagesContentWithImport;

  if (pagesContent.contains(featureComment)) {
    // Feature comment exists, add import after existing feature imports
    final featureImportPattern = RegExp(
      r"(// " +
          featurePage.toPascalCase() +
          r"\n(?:import 'package:poke_vault_mobile_app/features/" +
          featurePage +
          r"/presentation/pages/[^']+\.page\.dart';\n)+)",
      multiLine: true,
    );

    updatedPagesContentWithImport = pagesContent.replaceFirstMapped(
      featureImportPattern,
      (match) => '${match.group(0)}$pageImport\n',
    );
  } else {
    // Feature comment doesn't exist, add comment + import before "part 'routes.dart';"
    updatedPagesContentWithImport = pagesContent.replaceFirst(
      RegExp(r"(\npart\s+\'routes\.dart\';)"),
      "$featureComment\n$pageImport\n\npart 'routes.dart';",
    );
  }

  // Prepare new GetPage (without binding) - use camelCase for route variable
  final newGetPage =
      "    GetPage(name: Routes.$routeVarName, page: () => const ${pageName.toPascalCase()}Page()),";

  // Tambahkan GetPage baru sebelum "];" di dalam list pages
  final updatedPagesContentFinal = updatedPagesContentWithImport
      .replaceFirstMapped(
        RegExp(r'(\];\s*\})'), // Cari tanda "];" diikuti penutup kelas "}"
        (match) => '$newGetPage\n  ];\n}', // Tambahkan GetPage
      );

  // Tulis ulang file pages.dart
  pagesFile.writeAsStringSync(updatedPagesContentFinal);

  print('✅ Route and page added successfully.');

  // Register controller in feature binding
  _addControllerToBinding(featurePage, pageName);
}

void _addControllerToBinding(String featureName, String pageName) {
  final bindingPath =
      'lib/app/bindings/feature_bindings/${featureName}_binding.dart';
  final bindingFile = File(bindingPath);

  if (!bindingFile.existsSync()) {
    print(
      '⚠️  Binding file not found: $bindingPath. Please register controller manually.',
    );
    return;
  }

  var content = bindingFile.readAsStringSync();

  // Check if controller already registered
  final controllerClassName = '${pageName.toPascalCase()}Controller';
  if (content.contains(controllerClassName)) {
    print('⚠️  Controller already registered in bindings');
    return;
  }

  // Add import for controller
  final controllerImport =
      "import 'package:poke_vault_mobile_app/features/$featureName/presentation/controllers/$pageName.controller.dart';";

  // Find the class declaration and add import before it
  final classPattern =
      r'\n\s*class\s+' +
      featureName.toPascalCase() +
      r'Binding[s]?\s+extends\s+Bindings\s*\{';

  content = content.replaceFirstMapped(
    RegExp(classPattern, multiLine: true),
    (match) => '$controllerImport${match.group(0)}',
  );

  // Add controller registration before the closing braces
  // Find the pattern "  }\n}" which is the end of dependencies() method and class
  final controllerRegistration =
      "\n    // Controllers\n    Get.lazyPut(() => $controllerClassName(), fenix: true);";

  // Check if there's already a "// Controllers" comment
  if (content.contains('// Controllers')) {
    // Add after existing controllers section, before closing braces
    content = content.replaceFirstMapped(
      RegExp(r'(\s+Get\.lazyPut\([^;]+Controller\(\)[^;]*;\s*)(\n\s*\}\s*\})'),
      (match) =>
          "${match.group(1)}\n    Get.lazyPut(() => $controllerClassName(), fenix: true);${match.group(2)}",
    );
  } else {
    // Add new controllers section before closing braces
    content = content.replaceFirstMapped(
      RegExp(r'(\n\s*\}\s*\}\s*)$'),
      (match) => '$controllerRegistration${match.group(0)}',
    );
  }

  bindingFile.writeAsStringSync(content);
  print('✅ Controller registered in ${featureName}_binding.dart');
}
