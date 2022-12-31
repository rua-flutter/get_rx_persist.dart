library get_rx_persist;

import 'package:get_rx_persist/src/provider/get_storage_provider.dart';
import 'package:get_rx_persist/src/storage_provider.dart';

export 'package:get_rx_persist/src/get_rx_extension.dart';
export 'package:get_rx_persist/src/provider/mock_storage_provider.dart';

/// GetRxPersist
///
/// Get Rx Persist Configuration Class
/// in most case, you should call 'await GetRxPersist.initialize();' before app start
abstract class GetRxPersist {
  static StorageProvider defaultProvider = throw UnimplementedError();

  /// initialize the GetRxPersist.
  /// it will load will ALL persisted data to memory with the default [provider].
  /// note: you can change provider for specific value by using '.persist(provider: YOUR_PROVIDER)'.
  static Future<void> init({
    StorageProvider? provider,
    String name = 'GetRxPersist'
  }) async {
    defaultProvider = provider ?? GetStorageProvider(name);
    await defaultProvider.init();
  }
}
