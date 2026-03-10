// ignore_for_file: avoid_print
import 'dart:io';

import 'extensions.dart';

enum ModelType {
  request,
  response;

  String get folder => this == ModelType.request ? 'request' : 'response';
  String get suffix => this == ModelType.request ? 'req' : 'res';
}

class ModelField {
  final String name;
  final String type;
  final String? jsonKey;

  ModelField({
    required this.name,
    required this.type,
    this.jsonKey,
  });
}

Future<void> createModel({
  required String featureName,
  required String modelName,
  required ModelType modelType,
  List<ModelField>? fields,
  bool isList = false,
}) async {
  final featurePath = 'lib/features/$featureName';
  final featureDir = Directory(featurePath);

  if (!featureDir.existsSync()) {
    print('📂 ERROR: Feature "$featureName" does not exist');
    return;
  }

  final modelPath =
      '$featurePath/domain/models/${modelType.folder}/${modelName.toLowerCase()}_${modelType.suffix}.dart';
  final modelFile = File(modelPath);

  if (modelFile.existsSync()) {
    print('📄 Model ${modelName}_${modelType.suffix} already exists');
    return;
  }

  await modelFile.create(recursive: true);

  String content;
  if (modelType == ModelType.response) {
    content = _generateResponseModel(
      modelName: modelName,
      fields: fields ?? [],
      isList: isList,
    );
  } else {
    content = _generateRequestModel(
      modelName: modelName,
      fields: fields ?? [],
    );
  }

  await modelFile.writeAsString(content);
  print('📄 Model ${modelName}_${modelType.suffix} created at $modelPath');
}

String _generateResponseModel({
  required String modelName,
  required List<ModelField> fields,
  required bool isList,
}) {
  final className = '${modelName.toPascalCase()}Res';
  final dataClassName = modelName.toPascalCase();
  final fileName = '${modelName.toLowerCase()}_res';

  final buffer = StringBuffer();

  // Imports
  buffer.writeln("import 'package:json_annotation/json_annotation.dart';");
  buffer.writeln(
    "import 'package:albahjah_pustaka_mobile/config/bases/base_response.dart';",
  );
  buffer.writeln();
  buffer.writeln("part '$fileName.g.dart';");
  buffer.writeln();

  // Response class
  final returnType = isList ? 'List<$dataClassName>' : dataClassName;
  buffer.writeln('@JsonSerializable()');
  buffer.writeln('class $className extends BaseResponse<$returnType> {');
  buffer.writeln('  $className() : super();');
  buffer.writeln();
  buffer.writeln(
    '  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);',
  );
  buffer.writeln(
    '  Map<String, dynamic> toJson() => _\$${className}ToJson(this);',
  );
  buffer.writeln('}');
  buffer.writeln();

  // Data class
  buffer.writeln('@JsonSerializable()');
  buffer.writeln('class $dataClassName {');

  // Fields
  for (final field in fields) {
    final jsonKeyName = field.jsonKey ?? field.name;
    buffer.writeln("  @JsonKey(name: '$jsonKeyName')");
    buffer.writeln('  final ${field.type} ${field.name};');
    buffer.writeln();
  }

  // Constructor
  buffer.writeln('  $dataClassName({');
  for (final field in fields) {
    buffer.writeln('    this.${field.name},');
  }
  buffer.writeln('  });');
  buffer.writeln();

  // fromJson & toJson
  buffer.writeln(
    '  factory $dataClassName.fromJson(Map<String, dynamic> json) => _\$${dataClassName}FromJson(json);',
  );
  buffer.writeln(
    '  Map<String, dynamic> toJson() => _\$${dataClassName}ToJson(this);',
  );
  buffer.writeln('}');

  return buffer.toString();
}

String _generateRequestModel({
  required String modelName,
  required List<ModelField> fields,
}) {
  final className = '${modelName.toPascalCase()}Req';
  final fileName = '${modelName.toLowerCase()}_req';

  final buffer = StringBuffer();

  // Imports
  buffer.writeln("import 'package:json_annotation/json_annotation.dart';");
  buffer.writeln();
  buffer.writeln("part '$fileName.g.dart';");
  buffer.writeln();

  // Request class
  buffer.writeln('@JsonSerializable()');
  buffer.writeln('class $className {');

  // Fields
  for (final field in fields) {
    final jsonKeyName = field.jsonKey ?? field.name;
    buffer.writeln("  @JsonKey(name: '$jsonKeyName')");
    buffer.writeln('  final ${field.type} ${field.name};');
    buffer.writeln();
  }

  // Constructor
  buffer.writeln('  $className({');
  for (final field in fields) {
    final isRequired = !field.type.endsWith('?');
    if (isRequired) {
      buffer.writeln('    required this.${field.name},');
    } else {
      buffer.writeln('    this.${field.name},');
    }
  }
  buffer.writeln('  });');
  buffer.writeln();

  // fromJson & toJson
  buffer.writeln(
    '  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);',
  );
  buffer.writeln(
    '  Map<String, dynamic> toJson() => _\$${className}ToJson(this);',
  );
  buffer.writeln('}');

  return buffer.toString();
}
