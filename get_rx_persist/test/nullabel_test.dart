import 'dart:convert';
import 'dart:math';

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

      final intVal = Rx<int?>(null).persist('intVal');

      expect(intVal.value, null);
    });

    test('data persisted', () {
      provider.reset();
      final intVal = Rx<int?>(0).persist('intVal');

      intVal.value = null;

      expect(provider.delCalledCount, 1);
    });
  });
}