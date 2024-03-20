/// The class [AppImages] provides a convenient way to access image paths within the app.
///
/// To use this class, import 'package:flutter/material.dart' and 'package:your_app_name/app_images.dart'.
/// Once imported, you can use the static constant 'logo' to display an image in your Flutter app.
///
/// Example usage:
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:your_app_name/app_images.dart';
///
/// // ...
///
/// Image.asset(
///   AppImages.logo,
///   width: 100,
///   height: 100,
/// )
/// ```
///
/// In this example, the static constant 'logo' is assumed to be the path to the logo image, such as 'assets/images/logo.png'.
/// You can adjust the width and height properties to fit your desired image size.
///
/// Please ensure that you have the necessary imports and that the app_images.dart file is located correctly within your project.
abstract final class AppImages {
  AppImages._();

  // static const String logo = 'assets/images/logo.png';
}
