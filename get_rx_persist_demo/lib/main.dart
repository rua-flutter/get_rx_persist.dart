import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_rx_persist/get_rx_persist.dart';
import 'package:get_rx_persist_demo/page/counter_page.dart';
import 'package:get_rx_persist_demo/store/counter_store.dart';

void main() async {
  await GetRxPersist.init();
  Get.put(CounterStore());

  runApp(
    const GetMaterialApp(
      home: CounterPage(),
    ),
  );
}
