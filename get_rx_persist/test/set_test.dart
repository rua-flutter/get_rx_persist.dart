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

    setUp(() async {
      await GetRxPersist.init(provider: provider);
    });

    test('data restored', () {
      provider.reset();
      provider.set('objectSetVal', [
        object,
      ]);
      provider.set('intSetVal', [
        1,
      ]);

      final objectVal = <TestSerializableObject>{}.obs.persist(
            'objectSetVal',
            deserializer: TestSerializableObject.fromJson,
          );

      final intVal = <int>{}.obs.persist(
            'intSetVal',
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
      final objectVal = <TestSerializableObject>{}.obs.persist(
            'objectSetVal',
            serializer: (instance) => instance.toJson(),
            deserializer: TestSerializableObject.fromJson,
          );

      final intVal = <int>{}.obs.persist(
            'intSetVal',
          );

      objectVal.add(object);
      intVal.add(1);

      expect(objectVal.length, 1);
      expect(objectVal.first, object);
      expect(intVal.length, 1);
    });
  });
}
