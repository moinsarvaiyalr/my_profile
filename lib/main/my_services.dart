import 'package:flutter/services.dart';
import 'package:flutter_practical/core/theme/color_palette.dart';
import 'package:get_storage/get_storage.dart';

import '../core/app_preference/app_preferences.dart';
import '../core/constants/app_strings.dart';

/// A service class for managing storage and user authentication functionality.
class MyService {
  MyService._();

  static MyService? _instance;

  /// Gets the singleton instance of MyService.
  static MyService get instance => _instance!;

  /// Initializes the MyService instance.
  ///
  /// This method must be called before using any other methods of MyService.
  /// It initializes the storage and sets up the instance.
  static Future<MyService> init() async {
    if (_instance == null) {
      await GetStorage.init();
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: ColorPalette.colorWhite,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
      _instance = MyService._();
    }
    return _instance!;
  }

  /// Checks if the user is logged in.
  ///
  /// Returns true if the user is logged in, otherwise false.
  Future<bool?> isLoggedIn() async {
    return await AppPreferences().sharedPrefRead(
      AppStrings.rememberMe,
    );
// You might want to implement the actual logic here
  }
}
