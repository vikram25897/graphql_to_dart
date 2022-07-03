import 'dart:async';
import 'dart:io';

import 'package:graphql_to_dart/src/builders/type_builder.dart';
import 'package:graphql_to_dart/src/constants/files.dart';
import 'package:graphql_to_dart/src/constants/type_converters.dart';
import 'package:graphql_to_dart/src/introspection_api_client/client.dart';
import 'package:graphql_to_dart/src/models/config.dart';
import 'package:graphql_to_dart/src/models/graphql_types.dart';
import 'package:graphql_to_dart/src/parsers/config_parser.dart';

class GraphQlToDart {
  final String yamlFilePath;
  GraphQlToDart(this.yamlFilePath);
  static const List<String> ignoreFields = [
    "rootquerytype",
    "rootsubscriptiontype",
    "rootmutationtype",
    "mutation",
    "query",
    "subscription"
  ];

  init() async {
    Config config = await ConfigParser.parse(yamlFilePath);
    ValidationResult result = await config.validate();
    if (result.hasError!) {
      throw result.errorMessage!;
    }
    LocalGraphQLClient localGraphQLClient = LocalGraphQLClient();
    localGraphQLClient.init(config);
    final schema = await localGraphQLClient.fetchTypes();
    TypeConverters converters = TypeConverters();
    converters.overrideTypes(config.typeOverride);
    await Future.forEach(schema.types!, (Types type) async {
      if (type.fields != null &&
          type.inputFields == null &&
          !type.name!.startsWith("__") &&
          !ignoreFields.contains(type.name?.toLowerCase())) {
        print("Creating model from: ${type.name}");
        TypeBuilder builder = TypeBuilder(type, config);
        await builder.build();
      }
    });
    print("Formatting Generated Files");
    await runFlutterFormat();
    return;
  }

  Future runFlutterFormat() async {
    Process.runSync(
      "flutter",
      ["format", FileConstants().modelsDirectory.path],
      runInShell: true,
    );
    print("Formatted Generated Files");
  }
}
