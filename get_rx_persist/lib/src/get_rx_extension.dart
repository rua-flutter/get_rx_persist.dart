import 'dart:convert';

import 'package:get/get_rx/get_rx.dart';
import 'package:get_rx_persist/get_rx_persist.dart';
import 'package:get_rx_persist/src/storage_provider.dart';

// extension GetRxExtension<T> on T {
//
// }

extension GetRxPersistExtension<T> on Rx<T> {
  Rx<T> persist(String key, {StorageProvider? provider, Deserializer<T>? deserializer}) {
    final usingProvider = provider ?? GetRxPersist.defaultProvider;

    final persistValue = usingProvider.get<String>(key);

    if (persistValue != null) {
      final json = jsonDecode(persistValue);

      if (deserializer != null) {
        value = deserializer(json);
      } else {
        assert(json is T, "expect type $T receive type ${persistValue.runtimeType}");
        value = json as T;
      }
    }

    listen((value) {
      usingProvider.set<String>(key, json.encode(value));
    });

    return this;
  }
}

extension GetRxPersistMapExtension<K, V> on RxMap<K, V> {

}

extension GetRxPersistIntExtension<T> on int {
  int persist(String key, {StorageProvider? provider}) {
    return this;
  }
}

typedef Deserializer<R> = R Function(Map<String, dynamic> jsonMap);