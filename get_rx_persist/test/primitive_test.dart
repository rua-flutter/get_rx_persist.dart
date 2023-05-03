import 'package:flutter_test/flutter_test.dart';
import 'package:get_rx_persist/get_rx_persist.dart';

void main() {
  group('primitive value', () {
    final provider = MockStorageProvider('MOCK');

    setUp(() async {
      await GetRxPersist.init(provider: provider);
    });

    test('data restored', () {
      provider.reset();
      provider.set('intVal', 2);
      provider.set('doubleVal', 3.0);
      provider.set('numVal1', 4);
      provider.set('numVal2', 5.0);
      provider.set('stringVal', 'str');
      provider.set('boolVal', true);

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

    test('data persisted', () async {
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
      await Future.delayed(Duration(milliseconds: 20));
      expect(provider.getCalledCount, 6);
      expect(provider.setCalledCount, 6);
    });
  });
}
