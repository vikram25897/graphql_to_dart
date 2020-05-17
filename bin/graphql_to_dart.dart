import 'dart:io';

import 'package:graphql_to_dart/graphql_to_dart.dart';

void main() {
  GraphQlToDart graphQlToDart = GraphQlToDart("graphql_config.yaml");
  graphQlToDart.init();

}