import 'package:flutter_test/flutter_test.dart';
import 'package:get_rx_persist/get_rx_persist.dart';

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

void main() {
  group('list', () {
    final provider = MockStorageProvider('MOCK');
    final object = TestSerializableObject(
      intVal: 1,
      stringVal: 'str',
      boolVal: true,
    );

    setUp(() async {
      await GetRxPersist.init(provider: provider);
    });

    test('data restored', () {
      provider.reset();
      provider.set('objectListVal', [
        object,
      ]);
      provider.set('intListVal', [
        1,
      ]);

      final objectVal = <TestSerializableObject>[].obs.persist(
            'objectListVal',
            deserializer: TestSerializableObject.fromJson,
          );

      final intVal = <int>[].obs.persist(
            'intListVal',
          );

      expect(objectVal.length, 1);
      expect(objectVal.first, isA<TestSerializableObject>());
      expect(objectVal.first.intVal, 1);
      expect(objectVal.first.stringVal, 'str');
      expect(objectVal.first.boolVal, true);

      expect(intVal.length, 1);
    });

    test('data persisted', () {
      provider.reset();
      final objectVal = <TestSerializableObject>[].obs.persist(
            'objectListVal',
            serializer: (instance) => instance.toJson(),
            deserializer: TestSerializableObject.fromJson,
          );

      final intVal = <int>[].obs.persist(
        'intListVal',
      );

      objectVal.add(object);
      intVal.add(1);

      expect(objectVal.length, 1);
      expect(objectVal.first, object);
      expect(intVal.length, 1);
    });
  });
}
