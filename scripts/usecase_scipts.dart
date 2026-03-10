// ignore_for_file: avoid_print
import 'dart:io';

import 'extensions.dart';

enum UseCaseType {
  get,
  post,
  put,
  delete;

  String get methodApi {
    switch (this) {
      case UseCaseType.get:
        return '@GET(Apis.)';
      case UseCaseType.post:
        return '@POST(Apis.)';
      case UseCaseType.put:
        return '@PUT(Apis.)';
      case UseCaseType.delete:
        return '@DELETE(Apis.)';
    }
  }

  static UseCaseType fromString(String type) => UseCaseType.values.firstWhere(
    (elm) => elm.name.toLowerCase() == type.toLowerCase(),
  );
}

Future<void> createUseCase(
  String useCaseName,
  String featureName,
  UseCaseType type,
) async {
  final featurePath = 'lib/features/$featureName';

  final featureDir = Directory(featurePath);
  if (!featureDir.existsSync()) {
    print('📂 ERROR: Feature "$featureName" does not exist');
    return;
  }
  _createMethodOnRepository(useCaseName, featureName);
  _createMethodOnSource(useCaseName, featureName, type);
  _createMethodOnRepositoryImpl(useCaseName, featureName);
  _createUseCase(useCaseName, featureName);
  _signUseCaseIntoBindings(useCaseName, featureName);
}

// create method on repository
void _createMethodOnRepository(String name, String featureName) {
  final file = File(
    'lib/features/$featureName/domain/repositories/${featureName}_repository.dart',
  );

  final methodName = name.toCamelCase();
  final content = file.readAsStringSync();
  final updatedContent = content.replaceFirst(
    RegExp(r'}'),
    '\n  Future<DataState<T>> $methodName();\n}',
  );
  file.writeAsStringSync(updatedContent);
}

// create method on source
void _createMethodOnSource(String name, String featureName, UseCaseType type) {
  final file = File(
    'lib/features/$featureName/data/src/${featureName}_api_service.dart',
  );

  final methodName = name.toCamelCase();
  final content = file.readAsStringSync();
  final updatedContent = content.replaceFirst(
    RegExp(r'}'),
    '\n  ${type.methodApi}\n  Future<HttpResponse<T>> $methodName();\n}',
  );
  file.writeAsStringSync(updatedContent);
}

// create method on repository impl
void _createMethodOnRepositoryImpl(String name, String featureName) {
  final file = File(
    'lib/features/$featureName/data/repositories/${featureName}_repository_impl.dart',
  );

  final methodName = name.toCamelCase();
  final content = file.readAsStringSync();
  final updatedContent = content.replaceFirst(RegExp(r'}'), '''

  @override
  Future<DataState<T>> $methodName() {
    return getStateOf(
      request: () => ${featureName}ApiService.$methodName(),
    );
  }
}
''');
  file.writeAsStringSync(updatedContent);
}

// create usecase
void _createUseCase(String name, String featureName) {
  final file = File(
    'lib/features/$featureName/domain/usecases/${name}_uc.dart',
  );

  final useCaseName = name.toPascalCase();
  final methodName = name.toCamelCase();

  final content =
      '''
import 'package:albahjah_pustaka_mobile/config/bases/base_data_state.dart';
import 'package:albahjah_pustaka_mobile/config/bases/base_usecase.dart';
import 'package:albahjah_pustaka_mobile/features/$featureName/domain/repositories/${featureName}_repository.dart';

class ${useCaseName}Uc extends UseCase<DataState<T>, void> {
  final ${featureName.capitalize()}Repository ${featureName}Repository;
  ${useCaseName}Uc(this.${featureName}Repository);

  @override
  Future<DataState<T>> call({void request}) {
    return ${featureName}Repository.$methodName();
  }
}
''';

  file.writeAsStringSync(content);
}

// sign usecase into bindings

void _signUseCaseIntoBindings(String name, String featureName) {
  final file = File(
    'lib/app/bindings/feature_bindings/${featureName}_binding.dart',
  );
  final useCaseName = '${name.toPascalCase()}Uc';
  final content = file.readAsStringSync();

  // Perbaikan classPattern dengan PascalCase
  String classPattern =
      r'\n\s*class\s+' +
      featureName.toPascalCase() +
      r'Binding\s+extends\s+Bindings\s*\{';

  String newImport =
      "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/usecases/${name}_uc.dart';";

  String updatedContent = content.replaceFirstMapped(
    RegExp(classPattern, multiLine: true),
    (match) => '$newImport${match.group(0)}',
  );

  // Tambahkan dependencies baru sebelum `}` terakhir
  String pattern = r'\s*}\s*}\s*$';
  String newDependencies =
      '''

    Get.lazyPut(
      () => $useCaseName(Get.find<${featureName.toPascalCase()}Repository>()),
      fenix: true,
    );''';

  updatedContent = updatedContent.replaceAllMapped(RegExp(pattern), (match) {
    return '$newDependencies${match.group(0)}';
  });

  file.writeAsStringSync(updatedContent);
}
