import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_rx_persist/get_rx_persist.dart';

void main() {
  group('get_rx_persist', () {
    final provider = MockStorageProvider('MOCK');

    test('default provider', () async {
      // walk-around since this package do not provide native plugin modules
      try {
        await GetRxPersist.init();
      } catch (e) {
        expect(e, isA<MissingPluginException>());
      }
    });

    test('clear()', () {
      provider.set('key', 'value');
      expect(provider.get('key'), 'value');

      provider.clear();

      expect(provider.clearCalledCount, 1);
      expect(provider.get('key'), null);
    });
  });
}
