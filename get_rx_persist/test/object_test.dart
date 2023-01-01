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
  group('object tests', () {
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
      provider.set('objectVal', object);

      final objectVal = TestSerializableObject().obs.persist(
            'objectVal',
            deserializer: TestSerializableObject.fromJson,
          );

      expect(objectVal.value, isA<TestSerializableObject>());
      expect(objectVal.value.intVal, 1);
      expect(objectVal.value.stringVal, 'str');
      expect(objectVal.value.boolVal, true);
    });

    test('data persisted without serializer', () {
      provider.reset();
      final objectVal = TestSerializableObject().obs.persist(
        'objectVal',
        deserializer: TestSerializableObject.fromJson,
      );

      expect(objectVal.value, isA<TestSerializableObject>());
      expect(objectVal.value.intVal, null);
      expect(objectVal.value.stringVal, null);
      expect(objectVal.value.boolVal, null);

      objectVal.value = object;

      expect(provider.hasSetKey('objectVal'), true);
      expect(provider.hasSetKeyValue('objectVal', object), true);
      expect(objectVal.value, isA<TestSerializableObject>());
      expect(objectVal.value.intVal, 1);
      expect(objectVal.value.stringVal, 'str');
      expect(objectVal.value.boolVal, true);
    });

    test('data persisted with serializer', () {
      provider.reset();
      final objectVal = TestSerializableObject().obs.persist(
        'objectVal',
        deserializer: TestSerializableObject.fromJson,
        serializer: (instance) => instance.toJson(),
      );

      expect(objectVal.value, isA<TestSerializableObject>());
      expect(objectVal.value.intVal, null);
      expect(objectVal.value.stringVal, null);
      expect(objectVal.value.boolVal, null);

      objectVal.value = object;

      expect(provider.hasSetKey('objectVal'), true);
      // expect(provider.hasSetKeyValue('objectVal', object), true);
      expect(objectVal.value, isA<TestSerializableObject>());
      expect(objectVal.value.intVal, 1);
      expect(objectVal.value.stringVal, 'str');
      expect(objectVal.value.boolVal, true);
    });
  });
}
