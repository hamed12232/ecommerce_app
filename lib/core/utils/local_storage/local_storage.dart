import 'package:hive_flutter/hive_flutter.dart';

class TLocalStorage {
  TLocalStorage._();

  static final TLocalStorage _instance = TLocalStorage._();

  factory TLocalStorage.instance() => _instance;

  static late Box _box;

  /// Initialize Hive and open a box
  static Future<void> init(String bucketName) async {
    await Hive.initFlutter();
    _box = await Hive.openBox(bucketName);
  }

  /// Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _box.put(key, value);
  }

  /// Generic method to read data
  T? readData<T>(String key) {
    return _box.get(key) as T?;
  }

  /// Generic method to remove data
  Future<void> removeData(String key) async {
    await _box.delete(key);
  }

  /// Generic method to clear all data in the box
  Future<void> clearAll() async {
    await _box.clear();
  }

  /// Method to get all values from the box
  List<dynamic> getAllValues() {
    return _box.values.toList();
  }
}

// I'll make a more robust version below that supports multiple boxes if needed,
// but for now, the user wants "make class localstorage".
