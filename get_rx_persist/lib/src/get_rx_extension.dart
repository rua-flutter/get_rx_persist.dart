import 'dart:convert';

import 'package:get_rx_persist/get_rx_persist.dart';
import 'package:get_rx_persist/src/storage_provider.dart';

/// GetRxPersistExtension
///
/// persist support for both primitive value and object value
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
    final persistValue = usingProvider.get(key);

    // try to restore if persisted value is not empty
    if (persistValue != null) {
      if (deserializer != null) {
        value = deserializer(persistValue);
      } else {
        assert(persistValue is T,
            "expect type $T receive type ${persistValue.runtimeType}");
        value = persistValue as T;
      }
    }

    // persist data when value changed
    listen((value) async {
      if (value == null) {
        usingProvider.del(key);
        return;
      }

      if (serializer != null) {
        usingProvider.set(key, serializer(value));
        return;
      }

      usingProvider.set(key, value);
    });

    return this;
  }
}

extension GetRxPersistMapExtension<K, V> on RxMap<K, V> {
  RxMap<K, V> persist(
    String key, {
    StorageProvider? provider,
    Deserializer<K>? keyDeserializer,
    Serializer<K>? keySerializer,
    Deserializer<V>? valueDeserializer,
    Serializer<V>? valueSerializer,
  }) {
    // choose provider
    final usingProvider = provider ?? GetRxPersist.defaultProvider;

    // get persisted value
    final persistValue = usingProvider.get(key);

    if (persistValue != null) {
      value = (persistValue as Map<String, dynamic>).map((key, value) {
        final outKey = keyDeserializer != null
            ? keyDeserializer(jsonDecode(key))
            : jsonDecode(key) as K;
        final outValue =
            valueDeserializer != null ? valueDeserializer(value) : value as V;
        return MapEntry(outKey, outValue);
      });
    }

    // persist data when value changed
    listen((map) {
      final stringMap = map.map((key, value) {
        final stringKey = keySerializer != null
            ? jsonEncode(keySerializer(key))
            : jsonEncode(key);
        final stringValue =
            valueSerializer != null ? valueSerializer(value) : value;
        return MapEntry(stringKey, stringValue);
      });

      usingProvider.set(key, stringMap);
    });

    return this;
  }
}

extension GetRxPersistListExtension<E> on RxList<E> {
  RxList<E> persist(
    String key, {
    StorageProvider? provider,
    Deserializer<E>? deserializer,
    Serializer<E>? serializer,
  }) {
    // choose provider
    final usingProvider = provider ?? GetRxPersist.defaultProvider;

    // get persisted value
    final persistValue = usingProvider.get(key);

    // try to restore if persisted value is not empty
    if (persistValue != null) {
      if (deserializer != null) {
        value = (persistValue as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(deserializer)
            .cast<E>()
            .toList();
      } else {
        value = (persistValue as List<dynamic>).cast<E>().toList();
      }
    }

    // persist data when value changed
    listen((list) {
      if (serializer != null) {
        usingProvider.set(key, list.map(serializer).toList());
        return;
      }

      usingProvider.set(key, list);
    });

    return this;
  }
}

extension GetRxPersistSetExtension<E> on RxSet<E> {
  RxSet<E> persist(
    String key, {
    StorageProvider? provider,
    Deserializer<E>? deserializer,
    Serializer<E>? serializer,
  }) {
    // choose provider
    final usingProvider = provider ?? GetRxPersist.defaultProvider;

    // get persisted value
    final persistValue = usingProvider.get(key);

    // try to restore if persisted value is not empty
    if (persistValue != null) {
      if (deserializer != null) {
        assignAll((persistValue as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(deserializer)
            .cast<E>()
            .toSet());
      } else {
        // assert(json is T, "expect type $T receive type ${persistValue.runtimeType}");
        assignAll((persistValue as List<dynamic>).cast<E>().toSet());
      }
    }

    // persist data when value changed
    listen((list) {
      if (serializer != null) {
        usingProvider.set(key, list.map(serializer).toList());
        return;
      }

      usingProvider.set(key, list.toList());
    });

    return this;
  }
}

typedef Deserializer<R> = R Function(Map<String, dynamic> jsonMap);
typedef Serializer<T> = Map<String, dynamic> Function(T instance);
