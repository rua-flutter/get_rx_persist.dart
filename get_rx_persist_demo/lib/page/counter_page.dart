import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_rx_persist_demo/store/counter_store.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterStore counterStore = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Page'),
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('No Persist Int ${counterStore.notPersisted.value}'),
              Text('Persist Int: ${counterStore.persistedInt.value}'),
              Text('Persist String: ${counterStore.persistedString.value}'),
              Text('Persist Double: ${counterStore.persistedDouble.value}'),
              Text('Persist Bool: ${counterStore.persistedBool.value}'),
              Text('Persist Null: ${counterStore.persistedNullable.value}'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterStore.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
