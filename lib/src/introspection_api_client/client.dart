import 'package:graphql/client.dart';
import 'package:graphql_to_dart/src/introspection_api_client/queries.dart';
import 'package:graphql_to_dart/src/models/config.dart';
import 'package:graphql_to_dart/src/models/graphql_types.dart';

class LocalGraphQLClient {
  GraphQLClient client;

  init(Config config) {
    final HttpLink _httpLink = HttpLink(
       config.graphQLEndpoint,
    );
    client = GraphQLClient(
      cache: GraphQLCache(store:InMemoryStore()),
      link: _httpLink,
    );
  }

  Future<GraphQLSchema> fetchTypes() async {
    final queryResult =
        await client.query(QueryOptions(documentNode: gql(Queries.types)));
    if (queryResult.hasException) throw queryResult.exception.toString();
    return GraphQLSchema.fromJson(queryResult.data["__schema"]);
  }
}
