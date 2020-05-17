import 'dart:io';

import 'package:graphql_to_dart/src/constants/files.dart';
import 'package:yaml/yaml.dart';

class Config {
  String graphQLEndpoint;
//  String queriesFilePath;
//  String mutationsFilePath;
//  String subscriptionsFilePath;
  String packageName;
  String modelsDirectoryPath;
  YamlMap typeOverride;
  Config({this.modelsDirectoryPath});
  Config.fromJson(Map map) {
    graphQLEndpoint = map['graphql_endpoint']?.toString();
//    queriesFilePath = map['queries_file_path']?.toString();
//    mutationsFilePath = map['mutations_file_path']?.toString();
//    subscriptionsFilePath = map['subscriptions_file_path']?.toString();
    modelsDirectoryPath = map['models_directory_path']?.toString();
    ;
    packageName = map['package_name'];
    typeOverride = map['type_override'];
  }
  Future<ValidationResult> validate() async {
//    File queriesFile = File(queriesFilePath);
//    File mutationsFile = File(mutationsFilePath);
//    File subscriptionsFile = File(subscriptionsFilePath);
    Directory modelsDirectory = Directory(modelsDirectoryPath);
    try {
//      if(!(await queriesFile.exists()))
//        await createRecursive(queriesFile);
//      if(!(await mutationsFile.exists()))
//        await createRecursive(mutationsFile);
//      if(!(await subscriptionsFile.exists()))
//        print(await createRecursive(subscriptionsFile));
      if (!(await modelsDirectory.exists())) {
        print(await createRecursive(modelsDirectory));
      }
      if (packageName == null) {
        throw "Package Name Can't Be Empty";
      }
      FileConstants().modelsDirectory = modelsDirectory;
//      FileConstants().queriesFile = queriesFile;
//      FileConstants().mutationsFile = mutationsFile;
//      FileConstants().subscriptionsFile = subscriptionsFile;
      return ValidationResult(hasError: false);
    } catch (e) {
      return ValidationResult(hasError: true, errorMessage: e.toString());
    }
  }

  Future<FileSystemEntity> createRecursive(FileSystemEntity file) {
    if (file is File) {
      return file.create(recursive: true);
    } else {
      if (file is Directory) return file.create(recursive: true);
    }
    return null;
  }
}

class ValidationResult {
  bool hasError;
  String errorMessage;

  ValidationResult({this.hasError, this.errorMessage});
}
