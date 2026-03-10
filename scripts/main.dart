// ignore_for_file: avoid_print
import 'dart:io';

import 'enhanced_usecase_script.dart';
import 'feature_script.dart';
import 'model_script.dart';
import 'page_script.dart';
import 'usecase_scipts.dart';

// ANSI color codes
const String _reset = '\x1B[0m';
const String _red = '\x1B[31m';
const String _green = '\x1B[32m';
const String _yellow = '\x1B[33m';
const String _blue = '\x1B[34m';
const String _cyan = '\x1B[36m';
const String _bold = '\x1B[1m';

void main(List<String> args) async {
  // Always show interactive menu
  await _showInteractiveMenu();
}

Future<void> _showInteractiveMenu() async {
  while (true) {
    _printBanner();

    print('$_cyan${_bold}What would you like to generate?$_reset');
    print('');
    print('  ${_bold}1.$_reset Create Feature');
    print('  ${_bold}2.$_reset Create Page');
    print(
      '  ${_bold}3.$_reset Create UseCase (Full Flow) $_yellow[Recommended]$_reset',
    );
    print('  ${_bold}4.$_reset Create UseCase (Simple)');
    print('  ${_bold}5.$_reset Create Model');
    print('  ${_bold}0.$_reset Exit');
    print('');
    stdout.write('${_cyan}Select option (0-5): $_reset');

    final input = stdin.readLineSync();
    final selection = int.tryParse(input ?? '');

    print('');

    switch (selection) {
      case 1:
        await _createFeature();
        _pressEnterToContinue();
        break;
      case 2:
        await _createPage();
        _pressEnterToContinue();
        break;
      case 3:
        await _createFullUseCase();
        _pressEnterToContinue();
        break;
      case 4:
        await _createSimpleUseCase();
        _pressEnterToContinue();
        break;
      case 5:
        await _createModel();
        _pressEnterToContinue();
        break;
      case 0:
        print('$_yellow👋 Goodbye!$_reset');
        exit(0);
      default:
        print('$_red❌ Invalid option. Please select 0-5.$_reset');
        await Future.delayed(Duration(seconds: 1));
    }

    // Clear screen for next iteration
    _clearScreen();
  }
}

Future<void> _createFeature() async {
  _printSectionHeader('Create Feature');

  stdout.write('${_cyan}Feature name (snake_case): $_reset');
  final featureName = stdin.readLineSync()?.trim() ?? '';

  if (featureName.isEmpty) {
    print('$_red❌ Feature name cannot be empty$_reset');
    return;
  }

  print('');
  print('$_yellow⏳ Creating feature...$_reset');
  await createFeature(featureName);
  print('$_green✨ Feature created successfully!$_reset');
}

Future<void> _createPage() async {
  _printSectionHeader('Create Page');

  stdout.write('${_cyan}Page name (snake_case): $_reset');
  final pageName = stdin.readLineSync()?.trim() ?? '';

  if (pageName.isEmpty) {
    print('$_red❌ Page name cannot be empty$_reset');
    return;
  }

  stdout.write('${_cyan}Feature name: $_reset');
  final featureName = stdin.readLineSync()?.trim() ?? '';

  if (featureName.isEmpty) {
    print('$_red❌ Feature name cannot be empty$_reset');
    return;
  }

  stdout.write('${_cyan}Enable pagination? (y/n): $_reset');
  final hasPagination = stdin.readLineSync()?.toLowerCase() == 'y';

  print('');
  print('$_yellow⏳ Creating page...$_reset');
  await createPage(
    pageName.toLowerCase(),
    featureName.toLowerCase(),
    hasPagination,
  );
  print('$_green📄 Page created successfully!$_reset');
}

Future<void> _createFullUseCase() async {
  _printSectionHeader('Create UseCase (Full Flow)');

  stdout.write('${_cyan}UseCase name (e.g., login, get_products): $_reset');
  final useCaseName = stdin.readLineSync()?.trim() ?? '';

  if (useCaseName.isEmpty) {
    print('$_red❌ UseCase name cannot be empty$_reset');
    return;
  }

  stdout.write('${_cyan}Feature name: $_reset');
  final featureName = stdin.readLineSync()?.trim() ?? '';

  if (featureName.isEmpty) {
    print('$_red❌ Feature name cannot be empty$_reset');
    return;
  }

  print('');
  print('${_cyan}HTTP Method:$_reset');
  print('  ${_bold}1.$_reset GET');
  print('  ${_bold}2.$_reset POST');
  print('  ${_bold}3.$_reset PUT');
  print('  ${_bold}4.$_reset DELETE');
  stdout.write('${_cyan}Select (1-4): $_reset');

  final methodInput = int.tryParse(stdin.readLineSync() ?? '');
  final methods = ['get', 'post', 'put', 'delete'];

  if (methodInput == null || methodInput < 1 || methodInput > 4) {
    print('$_red❌ Invalid selection$_reset');
    return;
  }

  final selectedMethod = methods[methodInput - 1];

  stdout.write('${_cyan}API Endpoint (from Apis class): $_reset');
  final endpoint = stdin.readLineSync()?.trim() ?? '';

  if (endpoint.isEmpty) {
    print('$_red❌ Endpoint cannot be empty$_reset');
    return;
  }

  stdout.write('${_cyan}Has request body? (y/n): $_reset');
  final hasRequest = stdin.readLineSync()?.toLowerCase() == 'y';

  String? requestModel;
  if (hasRequest) {
    stdout.write('${_cyan}Request model name (e.g., login_req): $_reset');
    requestModel = stdin.readLineSync()?.trim();
    if (requestModel?.isEmpty ?? true) requestModel = null;
  }

  stdout.write('${_cyan}Has custom response? (y/n): $_reset');
  final hasResponse = stdin.readLineSync()?.toLowerCase() == 'y';

  String? responseModel;
  if (hasResponse) {
    stdout.write('${_cyan}Response model name (default: DefaultRes): $_reset');
    responseModel = stdin.readLineSync()?.trim();
    if (responseModel?.isEmpty ?? true) responseModel = 'DefaultRes';
  }

  bool useMultipart = false;
  if (hasRequest && selectedMethod != 'get') {
    stdout.write('${_cyan}Use multipart/form-data? (y/n): $_reset');
    useMultipart = stdin.readLineSync()?.toLowerCase() == 'y';
  }

  print('');
  print('$_yellow⏳ Creating complete usecase flow...$_reset');
  await createCompleteUseCase(
    useCaseName: useCaseName,
    featureName: featureName,
    httpMethod: HttpMethod.fromString(selectedMethod),
    apiEndpoint: endpoint,
    requestModel: requestModel,
    responseModel: responseModel,
    useMultipart: useMultipart,
  );
  print('$_green🚀 UseCase flow created successfully!$_reset');

  print('');
  print('$_yellow📝 Next steps:$_reset');
  print(
    '   1. Run: ${_blue}dart run build_runner build --delete-conflicting-outputs$_reset',
  );
  if (requestModel != null && requestModel != 'void') {
    print('   2. Create request model: $_blue$requestModel$_reset');
  }
  if (responseModel != null && responseModel != 'DefaultRes') {
    print('   3. Create response model: $_blue$responseModel$_reset');
  }
  print(
    '   4. Add endpoint to Apis class: ${_blue}lib/shared/constants/apis.dart$_reset',
  );
}

Future<void> _createSimpleUseCase() async {
  _printSectionHeader('Create UseCase (Simple)');

  stdout.write('${_cyan}UseCase name (snake_case): $_reset');
  final useCaseName = stdin.readLineSync()?.trim() ?? '';

  if (useCaseName.isEmpty) {
    print('$_red❌ UseCase name cannot be empty$_reset');
    return;
  }

  stdout.write('${_cyan}Feature name: $_reset');
  final featureName = stdin.readLineSync()?.trim() ?? '';

  if (featureName.isEmpty) {
    print('$_red❌ Feature name cannot be empty$_reset');
    return;
  }

  print('');
  print('${_cyan}HTTP Method:$_reset');
  print('  ${_bold}1.$_reset GET');
  print('  ${_bold}2.$_reset POST');
  print('  ${_bold}3.$_reset PUT');
  print('  ${_bold}4.$_reset DELETE');
  stdout.write('${_cyan}Select (1-4): $_reset');

  final methodInput = int.tryParse(stdin.readLineSync() ?? '');
  final methods = ['get', 'post', 'put', 'delete'];

  if (methodInput == null || methodInput < 1 || methodInput > 4) {
    print('$_red❌ Invalid selection$_reset');
    return;
  }

  print('');
  print('$_yellow⏳ Creating usecase...$_reset');
  await createUseCase(
    useCaseName.toLowerCase(),
    featureName.toLowerCase(),
    UseCaseType.fromString(methods[methodInput - 1]),
  );
  print('$_green🔨 UseCase created successfully!$_reset');
}

Future<void> _createModel() async {
  _printSectionHeader('Create Model');

  stdout.write('${_cyan}Model name (e.g., login_req, user_res): $_reset');
  final modelName = stdin.readLineSync()?.trim() ?? '';

  if (modelName.isEmpty) {
    print('$_red❌ Model name cannot be empty$_reset');
    return;
  }

  stdout.write('${_cyan}Feature name: $_reset');
  final featureName = stdin.readLineSync()?.trim() ?? '';

  if (featureName.isEmpty) {
    print('$_red❌ Feature name cannot be empty$_reset');
    return;
  }

  print('');
  print('${_cyan}Model type:$_reset');
  print('  ${_bold}1.$_reset Request');
  print('  ${_bold}2.$_reset Response');
  stdout.write('${_cyan}Select (1-2): $_reset');

  final typeInput = int.tryParse(stdin.readLineSync() ?? '');

  if (typeInput == null || typeInput < 1 || typeInput > 2) {
    print('$_red❌ Invalid selection$_reset');
    return;
  }

  final modelType = typeInput == 1 ? ModelType.request : ModelType.response;

  bool isList = false;
  if (modelType == ModelType.response) {
    stdout.write('${_cyan}Response returns a list? (y/n): $_reset');
    isList = stdin.readLineSync()?.toLowerCase() == 'y';
  }

  print('');
  print('$_yellow📝 Enter model fields:$_reset');
  print('   Format: <type> <name> [jsonKey]');
  print('   Examples:');
  print('     String email');
  print('     String? token');
  print('     int id userId');
  print('   Type ${_bold}done$_reset when finished');
  print('');

  final fields = <ModelField>[];
  var fieldNum = 1;

  while (true) {
    stdout.write('${_cyan}Field $fieldNum: $_reset');
    final input = stdin.readLineSync()?.trim() ?? '';

    if (input.toLowerCase() == 'done' || input.isEmpty) break;

    final parts = input.split(' ');
    if (parts.length < 2) {
      print('$_yellow⚠️  Invalid format. Use: <type> <name> [jsonKey]$_reset');
      continue;
    }

    final type = parts[0];
    final name = parts[1];
    final jsonKey = parts.length > 2 ? parts[2] : null;

    fields.add(ModelField(name: name, type: type, jsonKey: jsonKey));
    fieldNum++;
  }

  if (fields.isEmpty) {
    print('$_yellow⚠️  No fields added. Model not created.$_reset');
    return;
  }

  print('');
  _printFieldsPreview(fields);

  stdout.write('${_cyan}Create model with these fields? (y/n): $_reset');
  final confirm = stdin.readLineSync()?.toLowerCase() == 'y';

  if (!confirm) {
    print('$_red❌ Model creation cancelled.$_reset');
    return;
  }

  print('');
  print('$_yellow⏳ Creating model...$_reset');
  await createModel(
    featureName: featureName,
    modelName: modelName,
    modelType: modelType,
    fields: fields,
    isList: isList,
  );
  print('$_green📦 Model created successfully!$_reset');

  print('');
  print(
    '$_yellow📝 Next step: Run ${_blue}dart run build_runner build --delete-conflicting-outputs$_reset',
  );
}

void _printBanner() {
  print('');
  print(
    '$_cyan╔═══════════════════════════════════════════════════════╗$_reset',
  );
  print(
    '$_cyan║                                                       ║$_reset',
  );
  print(
    '$_cyan$_bold║        🚀  Clean Architecture Code Generator  🚀      ║$_reset',
  );
  print(
    '$_cyan║                                                       ║$_reset',
  );
  print('║           Albahjah Pustaka Mobile v1.0.0              ║');
  print(
    '$_cyan║                                                       ║$_reset',
  );
  print(
    '$_cyan╚═══════════════════════════════════════════════════════╝$_reset',
  );
  print('');
}

void _printSectionHeader(String title) {
  print('$_cyan$_bold═══ $title ═══$_reset');
  print('');
}

void _printFieldsPreview(List<ModelField> fields) {
  print('$_cyan╔═══════════════════════════════════════╗$_reset');
  print('$_cyan║         Fields Preview                ║$_reset');
  print('$_cyan╠═══════════════════════════════════════╣$_reset');
  for (var field in fields) {
    final jsonKey = field.jsonKey ?? field.name;
    print('║ ${field.type.padRight(15)} ${field.name.padRight(20)} ║');
    if (field.jsonKey != null) {
      print('${'║   → JSON: $jsonKey'.padRight(42)}║');
    }
  }
  print('$_cyan╚═══════════════════════════════════════╝$_reset');
}

void _pressEnterToContinue() {
  print('');
  stdout.write('${_yellow}Press Enter to continue...$_reset');
  stdin.readLineSync();
}

void _clearScreen() {
  if (Platform.isWindows) {
    print('\x1B[2J\x1B[0;0H');
  } else {
    print('\x1B[2J\x1B[3J\x1B[H');
  }
}
