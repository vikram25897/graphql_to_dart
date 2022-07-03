class GraphQLSchema {
  List<Types>? types;

  GraphQLSchema({this.types});

  GraphQLSchema.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      types = List<Types>.empty(growable: true);
      json['types'].forEach((v) {
        types!.add(Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Types {
  List<Fields>? fields;
  String? kind;
  String? name;
  Type? ofType;
  var inputFields;
  Types({this.fields, this.kind, this.name, this.ofType});

  Types.fromJson(Map<String, dynamic> json) {
    if (json['fields'] != null) {
      fields = List<Fields>.empty(growable: true);
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
    inputFields = json['inputFields'];
    kind = json['kind'];
    name = json['name'];
    ofType = json['ofType'] != null ? Type.fromJson(json['ofType']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.fields != null) {
      data['fields'] = this.fields!.map((v) => v.toJson()).toList();
    }
    data['kind'] = this.kind;
    data['name'] = this.name;
    data['ofType'] = this.ofType;
    return data;
  }
}

class Fields {
  String? description;
  String? name;
  Type? type;

  Fields({this.description, this.name, this.type});

  Fields.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['description'] = this.description;
    data['name'] = this.name;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Type {
  String? kind;
  String? name;
  Type? ofType;

  Type({this.kind, this.name, this.ofType});

  Type.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    name = json['name'];
    ofType = json['ofType'] != null ? Type.fromJson(json['ofType']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['name'] = this.name;
    if (this.ofType != null) {
      data['ofType'] = this.ofType!.toJson();
    }
    return data;
  }
}

class OfType {
  String? kind;
  String? name;

  OfType({this.kind, this.name});

  OfType.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['name'] = this.name;
    return data;
  }
}
