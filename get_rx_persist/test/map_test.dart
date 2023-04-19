import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_rx_persist/get_rx_persist.dart';

import 'data/test_serializable_object.dart';

void main() {
  group('list', () {
    final provider = MockStorageProvider('MOCK');
    final object = TestSerializableObject(
      intVal: 1,
      stringVal: 'str',
      boolVal: true,
    );

    final object2 = TestSerializableObject2(
      intVal: 2,
      stringVal: 'str2',
      boolVal: false,
    );

    setUp(() async {
      await GetRxPersist.init(provider: provider);
    });

    test('data restored', () {
      provider.reset();
      provider.set('objectListVal', {
        jsonEncode(object): object2.toJson(),
      });
      provider.set('intListVal', {
        jsonEncode(1): 1,
      });

      final objectVal =
          <TestSerializableObject, TestSerializableObject2>{}.obs.persist(
                'objectListVal',
                keyDeserializer: TestSerializableObject.fromJson,
                valueDeserializer: TestSerializableObject2.fromJson,
                valueSerializer: (instance) => instance.toJson(),
              );

      final intVal = <int, int>{}.obs.persist(
            'intListVal',
          );

      expect(objectVal.length, 1);
      expect(objectVal.keys.first, isA<TestSerializableObject>());
      expect(objectVal.keys.first.intVal, 1);
      expect(objectVal.keys.first.stringVal, 'str');
      expect(objectVal.keys.first.boolVal, true);

      expect(objectVal.values.first, isA<TestSerializableObject2>());
      expect(objectVal.values.first.intVal, 2);
      expect(objectVal.values.first.stringVal, 'str2');
      expect(objectVal.values.first.boolVal, false);

      expect(intVal.length, 1);
      expect(intVal.keys.first, 1);

      expect(intVal.values.first, 1);
    });

    test('data persisted', () async {
      provider.reset();
      final objectVal =
          <TestSerializableObject, TestSerializableObject2>{}.obs.persist(
                'objectListVal',
                keyDeserializer: TestSerializableObject.fromJson,
                valueDeserializer: TestSerializableObject2.fromJson,
                valueSerializer: (instance) => instance.toJson(),
              );

      final intVal = <int, int>{}.obs.persist(
            'intListVal',
          );

      objectVal[object] = object2;
      intVal[1] = 1;

      final objectVal2 =
          <TestSerializableObject, TestSerializableObject2>{}.obs.persist(
                'objectListVal',
                keyDeserializer: TestSerializableObject.fromJson,
                valueDeserializer: TestSerializableObject2.fromJson,
                valueSerializer: (instance) => instance.toJson(),
              );

      final intVal2 = <int, int>{}.obs.persist(
            'intListVal',
          );

      await Future.delayed(Duration(milliseconds: 2000));

      expect(objectVal2.length, 1);
      expect(objectVal2.keys.first, isA<TestSerializableObject>());
      expect(objectVal2.keys.first.intVal, 1);
      expect(objectVal2.keys.first.stringVal, 'str');
      expect(objectVal2.keys.first.boolVal, true);

      expect(objectVal2.values.first, isA<TestSerializableObject2>());
      expect(objectVal2.values.first.intVal, 2);
      expect(objectVal2.values.first.stringVal, 'str2');
      expect(objectVal2.values.first.boolVal, false);

      expect(intVal2.length, 1);
      expect(intVal2.keys.first, 1);

      expect(intVal2.values.first, 1);
    });
  });
}
