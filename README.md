# GraphQL To Dart

Generate Dart models from an GraphQL endpoint by running a simple command.
## Usage

Add `graphql_to_dart` as a dev dependency.

```yaml
    graphql_to_dart: 1.0.0
```

Create a `graphql_config.yaml` file in your project root directory.

A simple `graphql_config.yaml` file will look something like this:

```yaml
    package_name: my_awesome_app
    graphql_endpoint: https://example.com/graphql
    models_directory_path: lib/graphql/models/
    type_override:
      id: int
```

#### Note: All options except `type_override` are required.

Run the command `flutter packages pub run graphql_to_dart` if you are using Flutter, otherwise simply `pub run graphql_to_dart`.

You can find the generated models in the path you provided to `models_directory_path` argument in `graphql_config.yaml`.


### Milestones

- [x] Generate Models
- [ ] Support Enum
- [ ] Generate query, mutations and subscriptions strings compatible with [graphql](https://pub.dev/packages/graphql) package.
