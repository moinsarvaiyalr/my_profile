import 'package:get_storage/get_storage.dart';

/// Use to store data in local storage
final class AppPreferences {
  final userData = GetStorage(); // Instance of GetStorage for local storage

  static final AppPreferences _singleton =
      AppPreferences._(); // Singleton instance of AppPreferences

  factory AppPreferences() {
    return _singleton; // Returns the singleton instance of AppPreferences
  }

  AppPreferences._(); // Private constructor for singleton pattern

  /// Writes the given key-value pair to the local storage
  void sharedPrefWrite(String key, dynamic value) => userData.write(key, value);

  /// Reads and returns the value associated with the given key from local storage
  dynamic sharedPrefRead(String key) => userData.read(key);

  /// Removes the value associated with the given key from local storage
  void sharedPrefRemove(String key) => userData.remove(key);

  /// Erases all data stored in local storage
  void sharedPrefEraseAllData() => userData.erase();
}
