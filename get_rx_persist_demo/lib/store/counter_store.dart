import 'package:get/get.dart';
import 'package:get_rx_persist/get_rx_persist.dart';

class PersistedObject {
  int counter;

  PersistedObject({this.counter = 0});
}

class PersistedObject2 {
  int counter = 0;

  PersistedObject2({this.counter = 0});

  PersistedObject2.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    return data;
  }
}

class CounterStore {
  final notPersisted = 0.obs;
  final persistedInt = 0.obs.persist('counter.persistedInt');
  final persistedString = '-'.obs.persist('counter.persistedString');
  final persistedBool = false.obs.persist('counter.persistedBool');
  final persistedDouble = 0.obs.persist('counter.persistedDouble');
  final Rx<int?> persistedNullable = (0 as int?).obs.persist('counter.persistedNullable');

  final persistedObject = PersistedObject().obs.persist(
        'counter.persistedObject',
        deserializer: (json) => PersistedObject(counter: json['counter']),
        serializer: (instance) => {'counter': instance.counter},
      );

  final persistedObject2 = PersistedObject2().obs.persist(
        'counter.persistedObject2',
        deserializer: PersistedObject2.fromJson,
      );

  final persistedIntList = <int>[].obs.persist('counter.persistedIntList');
  final persistedStringList = <String>[].obs.persist('counter.persistedStringList');
  final persistedObjectList = <PersistedObject2>[].obs.persist(
        'counter.persistedObjectList',
        deserializer: PersistedObject2.fromJson,
      );

  final persistedIntSet = <int>[].obs.persist('counter.persistedIntSet');
  final persistedObjectSet = <PersistedObject2>[].obs.persist(
        'counter.persistedObjectSet',
        deserializer: PersistedObject2.fromJson,
      );

  final persistedIntMap = <int, String>{}.obs.persist('counter.persistedIntMap');
  final persistedObjectMap = <PersistedObject, PersistedObject2>{}.obs.persist(
        'counter.persistedObjectMap',
        keyDeserializer: (json) => PersistedObject(counter: json['counter']),
        keySerializer: (instance) => {'counter': instance.counter},
        valueDeserializer: PersistedObject2.fromJson,
      );

  void increment() {
    notPersisted.value++;
    persistedInt.value++;
    persistedString.value = persistedInt.value.toString();
    persistedBool.toggle();
    persistedNullable.value = persistedBool.isTrue ? 0 : null;

    persistedObject.value.counter = persistedObject.value.counter + 1;
    persistedObject.refresh();

    persistedObject2.value.counter = persistedObject2.value.counter + 1;
    persistedObject2.refresh();

    persistedIntList.add(persistedInt.value);
    persistedStringList.add('${persistedInt.value}');
    persistedObjectList.add(PersistedObject2(counter: persistedInt.value));

    persistedIntSet.add(persistedInt.value);
    persistedObjectSet.add(PersistedObject2(counter: persistedInt.value));
    persistedIntMap[persistedInt.value] = persistedInt.value.toString();
    persistedObjectMap[PersistedObject(counter: persistedInt.value)] = PersistedObject2(counter: persistedInt.value);
  }

  void reset() {
    notPersisted.value = 0;
    persistedInt.value = 0;
    persistedString.value = '-';
    persistedBool.value = false;
    persistedNullable.value = 0;
    persistedObject.value = PersistedObject();
    persistedObject2.value = PersistedObject2();
    persistedIntList.clear();
    persistedStringList.clear();
    persistedObjectList.clear();
    persistedIntSet.clear();
    persistedObjectSet.clear();
    persistedIntMap.clear();
    persistedObjectMap.clear();
  }
}
