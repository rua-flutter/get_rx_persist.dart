class TestSerializableObject {
  int? intVal;
  String? stringVal;
  bool? boolVal;

  TestSerializableObject({this.intVal, this.stringVal, this.boolVal});

  TestSerializableObject.fromJson(Map<String, dynamic> json) {
    intVal = json['intVal'];
    stringVal = json['stringVal'];
    boolVal = json['boolVal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intVal'] = this.intVal;
    data['stringVal'] = this.stringVal;
    data['boolVal'] = this.boolVal;
    return data;
  }
}

class TestSerializableObject2 {
  int? intVal;
  String? stringVal;
  bool? boolVal;

  TestSerializableObject2({this.intVal, this.stringVal, this.boolVal});

  TestSerializableObject2.fromJson(Map<String, dynamic> json) {
    intVal = json['intVal'];
    stringVal = json['stringVal'];
    boolVal = json['boolVal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intVal'] = this.intVal;
    data['stringVal'] = this.stringVal;
    data['boolVal'] = this.boolVal;
    return data;
  }
}