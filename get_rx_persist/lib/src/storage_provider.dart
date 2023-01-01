import 'dart:async';

/// StorageProvider
///
/// parent class for all StorageProvider
abstract class StorageProvider {
  /// name can be used as file name or table name or prefix key
  /// it totally depends on implementation
  final String name;

  StorageProvider(this.name);

  /// initialize the data which most-likely read data from its source, it can be local or remote.
  /// this will only be called once, please handle [Exception] in method.
  FutureOr<void> init();

  /// set persisted value with specific key
  void set<T>(String key, T value);

  /// get non-serialized persisted value for specific key
  T? get<T>(String key);

  /// delete persisted value for specific key
  void del(String key);

  /// remove all persisted value
  void clear();
}