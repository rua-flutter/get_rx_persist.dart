import 'package:get/get.dart';
import 'package:get_rx_persist/get_rx_persist.dart';

class CounterStore {
  final notPersisted = 0.obs;
  final persistedInt = 0.obs.persist('counter.persistedInt');
  final persistedString = '0'.obs.persist('counter.persistedString');
  final persistedBool = false.obs.persist('counter.persistedBool');
  final persistedDouble = 0.obs.persist('counter.persistedDouble');
  final Rx<int?> persistedNullable = (0 as int?).obs.persist('counter.persistedNullable');

  void increment() {
    notPersisted.value++;
    persistedInt.value++;
    persistedString.value = persistedInt.value.toString();
    persistedBool.toggle();
    persistedNullable.value = persistedBool.isTrue ? 0 : null;
  }
}