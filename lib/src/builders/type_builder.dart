import 'dart:io';

import 'package:graphql_to_dart/src/constants/files.dart';
import 'package:graphql_to_dart/src/constants/type_converters.dart';
import 'package:graphql_to_dart/src/models/config.dart';
import 'package:graphql_to_dart/src/models/graphql_types.dart';
import 'package:recase/recase.dart';
import 'package:graphql_to_dart/src/utils/helper_function.dart';

class TypeBuilder {
  static const String nonNull = "NON_NULL";
  static const String scalar = "SCALAR";
  static const String object = "OBJECT";
  final Types type;
  final Config config;
  final StringBuffer stringBuffer = StringBuffer();
  List<LocalField> localFields = [];

  TypeBuilder(this.type, this.config);

  Future build() async {
    _addFields();
    _addConstructor();
    _addFromJson();
    _addToJson();
    String current = stringBuffer.toString();
    stringBuffer.clear();
    current = _wrapWith(current, "class ${type.name}{", "}");
    stringBuffer.write(current.toString());
    _addImports();
    await _saveToFile();
  }

  _addImports() {
    StringBuffer importBuffer = StringBuffer();
    localFields.unique<String>((field) => field.type).forEach((field) {
      if (field.object == true) {
        if(config.dynamicImportPath){
        importBuffer.writeln(
            "import 'package:${config.packageName}/${config.modelsDirectoryPath.replaceAll(r"lib/", "")}/${pascalToSnake(field.type)}.dart';"
                .replaceAll(r"//", r"/"));
      }
        else{
          importBuffer.writeln(
            "import '${pascalToSnake(field.type)}.dart';"
                .replaceAll(r"//", r"/"));
        }
      }
    });
    String current = stringBuffer.toString();
    current = _wrapWith(current, importBuffer.toString() + "\n", "");
    stringBuffer.clear();
    stringBuffer.write(current);
  }

  _addToJson() {
    StringBuffer toJsonBuilder = StringBuffer();
    toJsonBuilder.writeln("Map _data = {};");
    localFields.forEach((field) {
      if (field.list == true) {
        if (field.type == "DateTime") {
          toJsonBuilder.writeln(
              "_data['${field.name}'] = List.generate(${field.name}?.length ?? 0, (index)=> ${field.name}[index].toString());");
        } else if (field.object == true) {
          toJsonBuilder.writeln(
              "_data['${field.name}'] = List.generate(${field.name}?.length ?? 0, (index)=> ${field.name}[index].toJson());");
        } else {
          toJsonBuilder.writeln("_data['${field.name}'] = ${field.name};");
        }
      } else if (field.object == true) {
        toJsonBuilder
            .writeln("_data['${field.name}'] = ${field.name}?.toJson();");
      } else if (field.type == "DateTime") {
        toJsonBuilder
            .writeln("_data['${field.name}'] = ${field.name}?.toString();");
      } else {
        toJsonBuilder.writeln("_data['${field.name}'] = ${field.name};");
      }
    });
    stringBuffer.writeln();
    toJsonBuilder.writeln("return _data;");
    stringBuffer.writeln();
    stringBuffer
        .write(_wrapWith(toJsonBuilder.toString(), "Map toJson(){", "}"));
  }
  
  _addFromJson() {
    StringBuffer fromJsonBuilder = StringBuffer();
    localFields.forEach((field) {
      if (field.list == true) {
        fromJsonBuilder.write("""
${field.name} = json['${field.name}']!=null ?
${field.object == true ? "List.generate(json['${field.name}'].length, (index)=> ${field.type}.fromJson(json['${field.name}'][index]))" : field.type == "DateTime" ? "List.generate(json['${field.name}'].length, (index)=> DateTime.parse(json['${field.name}'][index]))" : "json['${field.name}']"}: null;
        """);
      } else if (field.object == true) {
        fromJsonBuilder.writeln(
            "${field.name} = json['${field.name}']!=null ? ${field.type}.fromJson(json['${field.name}']) : null;");
      } else if (field.type == "DateTime") {
        fromJsonBuilder.writeln(
            "${field.name} = json['${field.name}']!=null ? DateTime.parse(json['${field.name}']) : null;");
      } else {
        fromJsonBuilder.writeln("${field.name} = json['${field.name}'];");
      }
    });
    stringBuffer.writeln();
    stringBuffer.writeln();
    stringBuffer.write(_wrapWith(fromJsonBuilder.toString(),
        "${type.name}.fromJson(Map<String, dynamic> json){", "}"));
  }

  _saveToFile() async {
    File file = File(FileConstants().modelsDirectory.path +
        "/${pascalToSnake(type.name)}.dart".replaceAll(r"//", r"/"));
    if (!(await file.exists())) {
      await file.create();
    }
    await file.writeAsString(stringBuffer.toString());
    return null;
  }

  _addFields() {
    type.fields.forEach((field) {
      _typeOrdering(field.type, field.name);
    });
  }

  _addConstructor() {
    StringBuffer constructorBuffer = StringBuffer();
    for (int i = 0; i < localFields.length; i++) {
      constructorBuffer.write("this.${localFields[i].name}");
      if (i < localFields.length - 1) {
        constructorBuffer.write(",");
      }
    }
    stringBuffer.writeln(
        _wrapWith(constructorBuffer.toString(), "${type.name}({", "});"));
  }

  _typeOrdering(Type type, String fieldName) {
    bool list = false;
    LocalField localField;
    if (type.kind == "NON_NULL") {
      type = type.ofType;
    }
    if (type.kind == "LIST") {
      list = true;
      type = type.ofType;
    }
    if (type.kind == "NON_NULL") {
      type = type.ofType;
    }
    if (type.kind == scalar) {
      localField = LocalField(
          name: fieldName,
          list: list,
          type: TypeConverters().nonObjectTypes[type.name.toLowerCase()],
          object: false);
      localFields.add(localField);
    } else {
      localField =
          LocalField(name: fieldName, list: list, type: type.name, object: true);
      localFields.add(localField);
    }
    stringBuffer.writeln(localField.toDeclarationStatement());
  }

  String _wrapWith(String input, String start, String end) {
    String updated = start + "\n" + input + "\n" + end;
    return updated;
  }

  String pascalToSnake(String pascalCasedString) {
    return ReCase(pascalCasedString).snakeCase;
  }
}

class LocalField {
  final String name;
  final bool list;
  final String type;
  final bool object;

  LocalField({this.name, this.list, this.type, this.object});

  String toDeclarationStatement() {
    return "${list ? "List<" : ""}${type ?? "var"}${list ? ">" : ""} $name;";
  }

  @override
  String toString() {
    // TODO: implement toString
    return type;
  }
}
