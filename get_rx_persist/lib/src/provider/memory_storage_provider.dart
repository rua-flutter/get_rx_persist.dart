import 'dart:async';
import 'dart:convert';

import 'package:get_rx_persist/src/storage_provider.dart';

/// MemoryStorageProvider
///
/// all data will stored in memory only
/// serialization and deserialization will applied.
class MemoryStorageProvider extends StorageProvider {
  final dict = <String, String>{};

  MemoryStorageProvider(super.name);

  @override
  FutureOr<void> init() {
    // noop
  }

  @override
  void clear() {
    dict.clear();
  }

  @override
  void del(String key) {
    dict.remove(key);
  }

  @override
  T? get<T>(String key) {
    if (!dict.containsKey(key)) {
      return null;
    }

    return jsonDecode(dict[key]!) as T?;
  }

  @override
  void set<T>(String key, T value) {
    dict[key] = jsonEncode(value);
  }
}