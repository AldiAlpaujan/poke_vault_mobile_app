// ignore_for_file: avoid_print
import 'dart:io';

import 'extensions.dart';

enum HttpMethod {
  get,
  post,
  put,
  delete;

  String get annotation {
    switch (this) {
      case HttpMethod.get:
        return '@GET';
      case HttpMethod.post:
        return '@POST';
      case HttpMethod.put:
        return '@PUT';
      case HttpMethod.delete:
        return '@DELETE';
    }
  }

  bool get needsBody => this == HttpMethod.post || this == HttpMethod.put;
  bool get usesQuery => this == HttpMethod.get;

  static HttpMethod fromString(String type) => HttpMethod.values.firstWhere(
        (elm) => elm.name.toLowerCase() == type.toLowerCase(),
      );
}

Future<void> createCompleteUseCase({
  required String useCaseName,
  required String featureName,
  required HttpMethod httpMethod,
  required String apiEndpoint,
  String? requestModel,
  String? responseModel,
  bool useMultipart = false,
}) async {
  final featurePath = 'lib/features/$featureName';

  final featureDir = Directory(featurePath);
  if (!featureDir.existsSync()) {
    print('📂 ERROR: Feature "$featureName" does not exist');
    return;
  }

  // Determine models
  final reqModel = requestModel ?? 'void';
  final resModel = responseModel ?? 'DefaultRes';

  print('🔨 Creating UseCase: $useCaseName');
  print('   Feature: $featureName');
  print('   Method: ${httpMethod.name.toUpperCase()}');
  print('   Request: $reqModel');
  print('   Response: $resModel');
  print('');

  // 1. Add method to Repository interface
  await _addMethodToRepository(
    useCaseName: useCaseName,
    featureName: featureName,
    requestModel: reqModel,
    responseModel: resModel,
  );

  // 2. Add method to API Service
  await _addMethodToApiService(
    useCaseName: useCaseName,
    featureName: featureName,
    httpMethod: httpMethod,
    apiEndpoint: apiEndpoint,
    requestModel: reqModel,
    responseModel: resModel,
    useMultipart: useMultipart,
  );

  // 3. Add method to Repository Implementation
  await _addMethodToRepositoryImpl(
    useCaseName: useCaseName,
    featureName: featureName,
    requestModel: reqModel,
    responseModel: resModel,
  );

  // 4. Create UseCase file
  await _createUseCaseFile(
    useCaseName: useCaseName,
    featureName: featureName,
    requestModel: reqModel,
    responseModel: resModel,
  );

  // 5. Register UseCase in Bindings
  await _registerUseCaseInBindings(
    useCaseName: useCaseName,
    featureName: featureName,
  );

  print('✅ UseCase "$useCaseName" created successfully!');
  print('');
  print('📝 Next steps:');
  print('   1. Run: dart run build_runner build --delete-conflicting-outputs');
  if (requestModel != null && requestModel != 'void') {
    print('   2. Create request model: $requestModel');
  }
  if (responseModel != null && responseModel != 'DefaultRes') {
    print('   3. Create response model: $responseModel');
  }
}

Future<void> _addMethodToRepository({
  required String useCaseName,
  required String featureName,
  required String requestModel,
  required String responseModel,
}) async {
  final file = File(
    'lib/features/$featureName/domain/repositories/${featureName}_repository.dart',
  );

  if (!file.existsSync()) {
    print('⚠️  Repository interface not found, skipping...');
    return;
  }

  final methodName = useCaseName.toCamelCase();
  var content = file.readAsStringSync();

  // Check if method already exists
  if (content.contains('$methodName(')) {
    print('⚠️  Method $methodName already exists in repository');
    return;
  }

  // Add import for response model if needed
  if (responseModel != 'DefaultRes' && !responseModel.contains('?')) {
    final resImport =
        "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/models/response/${responseModel.toLowerCase()}.dart';";
    if (!content.contains(resImport)) {
      content = content.replaceFirst(
        "import 'package:albahjah_pustaka_mobile/config/bases/base_data_state.dart';",
        "import 'package:albahjah_pustaka_mobile/config/bases/base_data_state.dart';\n$resImport",
      );
    }
  }

  // Add import for request model if needed
  if (requestModel != 'void' && !requestModel.contains('?')) {
    final reqImport =
        "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/models/request/${requestModel.toLowerCase()}.dart';";
    if (!content.contains(reqImport)) {
      content = content.replaceFirst(
        "import 'package:albahjah_pustaka_mobile/config/bases/base_data_state.dart';",
        "import 'package:albahjah_pustaka_mobile/config/bases/base_data_state.dart';\n$reqImport",
      );
    }
  }

  // Add method signature
  final params = requestModel != 'void' ? '$requestModel request' : '';
  final methodSignature =
      '  Future<DataState<$responseModel>> $methodName($params);';

  content = content.replaceFirst(
    RegExp(r'}[\s]*$'),
    '\n$methodSignature\n}',
  );

  file.writeAsStringSync(content);
  print('✓ Added method to repository interface');
}

Future<void> _addMethodToApiService({
  required String useCaseName,
  required String featureName,
  required HttpMethod httpMethod,
  required String apiEndpoint,
  required String requestModel,
  required String responseModel,
  required bool useMultipart,
}) async {
  final file = File(
    'lib/features/$featureName/data/src/${featureName}_api_service.dart',
  );

  if (!file.existsSync()) {
    print('⚠️  API Service not found, skipping...');
    return;
  }

  final methodName = useCaseName.toCamelCase();
  var content = file.readAsStringSync();

  // Check if method already exists
  if (content.contains('$methodName(')) {
    print('⚠️  Method $methodName already exists in API service');
    return;
  }

  // Add import for response model if needed
  if (responseModel != 'DefaultRes' && !responseModel.contains('?')) {
    final resImport =
        "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/models/response/${responseModel.toLowerCase()}.dart';";
    if (!content.contains(resImport)) {
      content = content.replaceFirst(
        "import 'package:dio/dio.dart';",
        "import 'package:dio/dio.dart';\n$resImport",
      );
    }
  }

  // Add import for request model if needed
  if (requestModel != 'void' && !requestModel.contains('?')) {
    final reqImport =
        "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/models/request/${requestModel.toLowerCase()}.dart';";
    if (!content.contains(reqImport)) {
      content = content.replaceFirst(
        "import 'package:dio/dio.dart';",
        "import 'package:dio/dio.dart';\n$reqImport",
      );
    }
  }

  // Build method signature
  final buffer = StringBuffer();
  buffer.writeln();

  // Add MultiPart annotation if needed
  if (useMultipart && httpMethod.needsBody) {
    buffer.writeln('  @MultiPart()');
  }

  // Add HTTP method annotation
  buffer.writeln('  ${httpMethod.annotation}(Apis.$methodName)');

  // Method signature
  buffer.write('  Future<HttpResponse<$responseModel>> $methodName(');

  if (requestModel != 'void') {
    if (httpMethod.usesQuery) {
      buffer.write('@Queries() $requestModel request');
    } else if (useMultipart) {
      // For multipart, we need to break down the request into @Part fields
      buffer.write('/* TODO: Add @Part fields from $requestModel */');
    } else {
      buffer.write('@Body() $requestModel request');
    }
  }

  buffer.writeln(');');

  // Insert before closing brace
  content = content.replaceFirst(
    RegExp(r'}[\s]*$'),
    '$buffer}',
  );

  file.writeAsStringSync(content);
  print('✓ Added method to API service');
}

Future<void> _addMethodToRepositoryImpl({
  required String useCaseName,
  required String featureName,
  required String requestModel,
  required String responseModel,
}) async {
  final file = File(
    'lib/features/$featureName/data/repositories/${featureName}_repository_impl.dart',
  );

  if (!file.existsSync()) {
    print('⚠️  Repository implementation not found, skipping...');
    return;
  }

  final methodName = useCaseName.toCamelCase();
  var content = file.readAsStringSync();

  // Check if method already exists
  if (content.contains('$methodName(')) {
    print('⚠️  Method $methodName already exists in repository implementation');
    return;
  }

  // Add import for response model if needed
  if (responseModel != 'DefaultRes' && !responseModel.contains('?')) {
    final resImport =
        "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/models/response/${responseModel.toLowerCase()}.dart';";
    if (!content.contains(resImport)) {
      final importPos = content.indexOf(
        "import 'package:albahjah_pustaka_mobile/features/$featureName/data/src/${featureName}_api_service.dart';",
      );
      if (importPos != -1) {
        content = content.replaceFirst(
          "import 'package:albahjah_pustaka_mobile/features/$featureName/data/src/${featureName}_api_service.dart';",
          "import 'package:albahjah_pustaka_mobile/features/$featureName/data/src/${featureName}_api_service.dart';\n$resImport",
        );
      }
    }
  }

  // Add import for request model if needed
  if (requestModel != 'void' && !requestModel.contains('?')) {
    final reqImport =
        "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/models/request/${requestModel.toLowerCase()}.dart';";
    if (!content.contains(reqImport)) {
      final importPos = content.indexOf(
        "import 'package:albahjah_pustaka_mobile/features/$featureName/data/src/${featureName}_api_service.dart';",
      );
      if (importPos != -1) {
        content = content.replaceFirst(
          "import 'package:albahjah_pustaka_mobile/features/$featureName/data/src/${featureName}_api_service.dart';",
          "import 'package:albahjah_pustaka_mobile/features/$featureName/data/src/${featureName}_api_service.dart';\n$reqImport",
        );
      }
    }
  }

  // Build method implementation
  final params = requestModel != 'void' ? '$requestModel request' : '';
  final apiCall = requestModel != 'void'
      ? '${featureName}ApiService.$methodName(request)'
      : '${featureName}ApiService.$methodName()';

  final methodImpl = '''

  @override
  Future<DataState<$responseModel>> $methodName($params) {
    return getStateOf(
      request: () => $apiCall,
    );
  }
''';

  content = content.replaceFirst(
    RegExp(r'}[\s]*$'),
    '$methodImpl}',
  );

  file.writeAsStringSync(content);
  print('✓ Added method to repository implementation');
}

Future<void> _createUseCaseFile({
  required String useCaseName,
  required String featureName,
  required String requestModel,
  required String responseModel,
}) async {
  final useCaseFile = File(
    'lib/features/$featureName/domain/usecases/${useCaseName.toLowerCase()}_uc.dart',
  );

  if (useCaseFile.existsSync()) {
    print('⚠️  UseCase file already exists');
    return;
  }

  await useCaseFile.create(recursive: true);

  final className = '${useCaseName.toPascalCase()}Uc';
  final methodName = useCaseName.toCamelCase();
  final repoClassName = '${featureName.toPascalCase()}Repository';
  final repoVarName = '${featureName.toCamelCase()}Repository';

  final buffer = StringBuffer();

  // Imports
  buffer.writeln(
    "import 'package:albahjah_pustaka_mobile/config/bases/base_data_state.dart';",
  );
  buffer.writeln(
    "import 'package:albahjah_pustaka_mobile/config/bases/base_usecase.dart';",
  );
  buffer.writeln(
    "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/repositories/${featureName}_repository.dart';",
  );

  // Import response model
  if (responseModel != 'DefaultRes' && !responseModel.contains('?')) {
    buffer.writeln(
      "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/models/response/${responseModel.toLowerCase()}.dart';",
    );
  }

  // Import request model
  if (requestModel != 'void' && !requestModel.contains('?')) {
    buffer.writeln(
      "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/models/request/${requestModel.toLowerCase()}.dart';",
    );
  }

  buffer.writeln();

  // UseCase class
  final requestType = requestModel == 'void' ? 'void' : '$requestModel?';
  buffer.writeln(
    'class $className extends UseCase<DataState<$responseModel>, $requestType> {',
  );
  buffer.writeln('  final $repoClassName $repoVarName;');
  buffer.writeln('  $className(this.$repoVarName);');
  buffer.writeln();
  buffer.writeln('  @override');
  buffer.writeln(
    '  Future<DataState<$responseModel>> call({$requestType request}) {',
  );

  if (requestModel != 'void') {
    buffer.writeln('    return $repoVarName.$methodName(request!);');
  } else {
    buffer.writeln('    return $repoVarName.$methodName();');
  }

  buffer.writeln('  }');
  buffer.writeln('}');

  useCaseFile.writeAsStringSync(buffer.toString());
  print('✓ Created UseCase file');
}

Future<void> _registerUseCaseInBindings({
  required String useCaseName,
  required String featureName,
}) async {
  final bindingFile = File(
    'lib/app/bindings/feature_bindings/${featureName}_binding.dart',
  );

  if (!bindingFile.existsSync()) {
    print('⚠️  Binding file not found, skipping registration...');
    return;
  }

  final className = '${useCaseName.toPascalCase()}Uc';
  var content = bindingFile.readAsStringSync();

  // Check if already registered
  if (content.contains(className)) {
    print('⚠️  UseCase already registered in bindings');
    return;
  }

  // Add import
  final useCaseImport =
      "import 'package:albahjah_pustaka_mobile/features/$featureName/domain/usecases/${useCaseName.toLowerCase()}_uc.dart';";

  final classPattern =
      r'\n\s*class\s+' + featureName.toPascalCase() + r'Binding\s+extends\s+Bindings\s*\{';

  content = content.replaceFirstMapped(
    RegExp(classPattern, multiLine: true),
    (match) => '$useCaseImport${match.group(0)}',
  );

  // Add dependency registration
  final repoClassName = '${featureName.toPascalCase()}Repository';
  final dependency = '''

    Get.lazyPut(
      () => $className(Get.find<$repoClassName>()),
      fenix: true,
    );''';

  content = content.replaceAllMapped(
    RegExp(r'\s*}\s*}\s*$'),
    (match) => '$dependency${match.group(0)}',
  );

  bindingFile.writeAsStringSync(content);
  print('✓ Registered UseCase in bindings');
}
