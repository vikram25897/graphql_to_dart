class Queries{
  static const String types = """
    {
  __schema{
    types{
      name
      kind
      ofType{
        name
        kind
        ofType{
          name
          kind
          ofType{
            name
            kind
          }
        }
      }
      fields{
        name
        description
        type{
        name
        kind
        ofType{
          name
          kind
          ofType{
            name
            kind
            ofType{
              name
              kind
            }
          }
        }
      }
      }
    }
  }
}
  """;
}