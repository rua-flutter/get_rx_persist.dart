import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_rx_persist/get_rx_persist.dart';

void main() {
  group('primitive value', () {
    final provider = MockStorageProvider('MOCK');

    setUp(() async {
      await GetRxPersist.init(
          provider: provider
      );
    });

    test('data restored', () {
      provider.reset();
      provider.set('intVal', jsonEncode(2));
      provider.set('doubleVal', jsonEncode(3.0));
      provider.set('numVal1', jsonEncode(4));
      provider.set('numVal2', jsonEncode(5.0));
      provider.set('stringVal', jsonEncode('str'));
      provider.set('boolVal', jsonEncode(true));

      final intVal = 0.obs.persist('intVal');
      final doubleVal = 0.0.obs.persist('doubleVal');
      final numVal1 = (0 as num).obs.persist('numVal1');
      final numVal2 = (0.0 as num).obs.persist('numVal2');
      final stringVal = ''.obs.persist('stringVal');
      final boolVal = false.obs.persist('boolVal');

      expect(provider.getCalledCount, 6);
      expect(intVal.value, 2);
      expect(doubleVal.value, 3);
      expect(numVal1.value, 4);
      expect(numVal2.value, 5);
      expect(stringVal.value, 'str');
      expect(boolVal.value, true);
    });

    test('data persisted', () {
      provider.reset();
      final intVal = 0.obs.persist('intVal');
      final doubleVal = 0.0.obs.persist('doubleVal');
      final numVal1 = (0 as num).obs.persist('numVal1');
      final numVal2 = (0.0 as num).obs.persist('numVal2');
      final stringVal = ''.obs.persist('stringVal');
      final boolVal = false.obs.persist('boolVal');

      intVal.value = 1;
      doubleVal.value = 2.0;
      numVal1.value = 2.0;
      numVal2.value = 2.0;
      stringVal.value = 'str';
      boolVal.value = true;

      expect(provider.getCalledCount, 6);
      expect(provider.setCalledCount, 6);
    });
  });
}