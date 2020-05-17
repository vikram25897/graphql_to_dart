class Attack {
  String name;
  String type;
  int damage;
  Attack({this.name, this.type, this.damage});

  Attack.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    damage = json['damage'];
  }

  Map toJson() {
    Map data = {};
    data['name'] = name;
    data['type'] = type;
    data['damage'] = damage;
    return data;
  }
}
