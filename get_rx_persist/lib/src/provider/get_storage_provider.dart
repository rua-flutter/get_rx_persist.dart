import 'dart:async';
import 'dart:convert';

import 'package:get_rx_persist/src/storage_provider.dart';
import 'package:get_storage/get_storage.dart' as getx;

class GetStorageProvider extends StorageProvider {
  GetStorageProvider(super.name);

  @override
  Future<void> init() async {
    await getx.GetStorage.init(name);
  }

  @override
  void clear() {
    getx.GetStorage(name).erase();
  }

  @override
  void del(String key) {
    getx.GetStorage(name).remove(key);
  }

  @override
  T? get<T>(String key) {
    final persistValue = getx.GetStorage(name).read(key);

    if (persistValue == null) {
      return null;
    }

    return jsonDecode(persistValue) as T?;
  }

  @override
  void set<T>(String key, T value) {
    getx.GetStorage(name).write(key, jsonEncode(value));
  }
}
