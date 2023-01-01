import 'package:get_rx_persist/src/provider/memory_storage_provider.dart';

/// MockStorageProvider
///
/// this class is used for testing in package and developer's code
/// all data will stored in memory only, check out [MemoryStorageProvider]
class MockStorageProvider extends MemoryStorageProvider {
  final getList = <String>[];
  final delList = <String>[];
  final setList = <MapEntry<String, dynamic>>[];

  int get setCalledCount => setList.length;
  int get getCalledCount => getList.length;
  int clearCalledCount = 0;
  int get delCalledCount => delList.length;

  MockStorageProvider(super.name);

  @override
  void clear() {
    clearCalledCount++;
    super.clear();
  }

  @override
  void del(String key) {
    delList.add(key);
    super.del(key);
  }

  @override
  void set<T>(String key, T value) {
    setList.add(MapEntry(key, value));

    super.set(key, value);
  }

  @override
  T? get<T>(String key) {
    getList.add(key);
    return super.get(key);
  }

  void reset() {
    clearCalledCount = 0;
    getList.clear();
    delList.clear();
    setList.clear();
    clear();
  }

  bool hasSetKey(String key) {
    return setList.where((el) => el.key == key).isNotEmpty;
  }

  bool hasSetKeyValue(String key, String value) {
    return setList.where((el) => el.key == key && el.value == value).isNotEmpty;
  }
}
