import 'dart:io';

import 'package:graphql_to_dart/src/models/config.dart';
import 'package:yaml/yaml.dart';

class ConfigParser{
  static Future<Config> parse(String rawYamlPath)async{
    print("here");
    File file = File(rawYamlPath);
    if(!(await file.exists()))
      throw "Config Yaml file doesn't exist";
    final YamlMap yaml = loadYaml(await file.readAsString()) as YamlMap;
    if(yaml == null)
      throw "YAML can't be parsed";
    return Config.fromJson(yaml);
  }
}