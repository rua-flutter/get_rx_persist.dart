import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_rx_persist/src/provider/get_storage_provider.dart';

void main() {
  group('get_storage', () {
    final getStorageProvider = GetStorageProvider('test');

    test('init', () {
      WidgetsFlutterBinding.ensureInitialized();
      getStorageProvider.init();
    });

    test('primitive value', () {
      WidgetsFlutterBinding.ensureInitialized();
      getStorageProvider.clear();
      getStorageProvider.set('key', {'a': 1.2});
      expect(getStorageProvider.get('key'), {'a': 1.2});

      getStorageProvider.del('key');
      expect(getStorageProvider.get('key'), null);

      getStorageProvider.set('key', {'a': 1.2});
      getStorageProvider.clear();
      expect(getStorageProvider.get('key'), null);
    });

  });
}