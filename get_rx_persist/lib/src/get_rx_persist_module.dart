import 'dart:async';

import 'package:get_module/get_module.dart';
import 'package:get_rx_persist/get_rx_persist.dart';

/// GetRxModule
///
/// add [Module] support for get_module
class GetRxPersistModule extends Module {
  @override
  Future<void> install() async {
    await GetRxPersist.init();
  }
}