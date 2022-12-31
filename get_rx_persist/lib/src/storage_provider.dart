import 'dart:async';

/// StorageProvider
///
/// parent class for all StorageProvider
abstract class StorageProvider {
  final String name;

  StorageProvider(this.name);

  /// initialize the data which most-likely read data from its source, it can be local or remote.
  /// this will only be called once, please handle [Exception] in method.
  FutureOr<void> init();

  void set<T>(String key, T value);

  T? get<T>(String key);

  void del(String key);

  void clear();
}