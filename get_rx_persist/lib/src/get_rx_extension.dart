import 'dart:convert';

import 'package:get/get_rx/get_rx.dart';
import 'package:get_rx_persist/get_rx_persist.dart';
import 'package:get_rx_persist/src/storage_provider.dart';

extension GetRxPersistExtension<T> on Rx<T> {
  Rx<T> persist(
    String key, {
    StorageProvider? provider,
    Deserializer<T>? deserializer,
    Serializer<T>? serializer,
  }) {
    // choose provider
    final usingProvider = provider ?? GetRxPersist.defaultProvider;

    // get persisted value
    final persistValue = usingProvider.get<String>(key);

    // try to restore if persisted value is not empty
    if (persistValue != null) {
      final json = jsonDecode(persistValue);

      if (deserializer != null) {
        value = deserializer(json);
      } else {
        assert(json is T, "expect type $T receive type ${persistValue.runtimeType}");
        value = json as T;
      }
    }

    // persist data when value changed
    listen((value) {
      if (serializer != null) {
        usingProvider.set<String>(key, jsonEncode(serializer(value)));
        return;
      }

      usingProvider.set<String>(key, jsonEncode(value));
    });

    return this;
  }
}

extension GetRxPersistMapExtension<K, V> on RxMap<K, V> {}

extension GetRxPersistListExtension<E> on RxList<E> {}

extension GetRxPersistSetExtension<E> on Set<E> {}

typedef Deserializer<R> = R Function(Map<String, dynamic> jsonMap);
typedef Serializer<T> = Map<String, dynamic> Function(T instance);
