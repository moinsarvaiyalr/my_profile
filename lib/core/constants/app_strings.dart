/// The class [AppStrings] provides a convenient way to access string constants within the app.
///
/// To use this class, import 'package:flutter/material.dart' and 'package:your_app_name/app_strings.dart'.
/// Once imported, you can access the static constant 'login' to display a login text in your Flutter app.
///
/// Example usage:
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:your_app_name/app_strings.dart';
///
/// // ...
///
/// Text(
///   AppStrings.login,
///   style: TextStyle(
///     fontSize: 16,
///     fontWeight: FontWeight.bold,
///   ),
/// )
/// ```
///
/// In this example, the static constant 'login' is set to the string "login". You can use it to display the login text
/// with the specified style in your Flutter app.
///
/// Please ensure that you have the necessary imports and that the app_strings.dart file is located correctly within your project.
abstract final class AppStrings {
  AppStrings._();

  static const String login = 'Login';
  static const String password = 'Password';
  static const String rememberMe = 'Remember me';
  static const String save = 'Save';
  static const String yes = 'Yes';
  static const String cricket = 'Cricket';
  static const String cancel = 'Cancel';
  static const String logOut = 'Logout';
  static const String edit = 'Edit';

  /// label strings
  static const String label = 'Label';
  static const String labelName = 'Name';
  static const String labelEmail = 'Email';
  static const String labelSkills = 'Skills';
  static const String labelStartDate = 'Start Date';
  static const String labelEndDate = 'End Date';
  static const String labelProfile = 'Profile';
  static const String labelTotalExperience = 'Total Experience';
  static const String labellogOut = 'Are you sure you want to Logout?';
  static const String profileUpdatedSucess = 'Profile updated successfully';
  static const String hintExperience = 'Total years of experience is :';
  static const String alert = 'Alert!';
  static const String discard = 'Discard';
  static const String labelPendingChanges =
      'Are you sure you want to discard all the changes?\n\nChanges is not saved yet.';

  /// hint strings
  static const String hint = 'Hint';
  static const String hintUserName = 'User Name';
  static const String hintEnterYourName = 'Enter your name';
  static const String hintEnterYourEmail = 'Enter your email';
  static const String hintEnterYourSkills = 'Add your skills';
  static const String hintdate = 'yyyy-mm-dd';
  static const String hintEmail = 'Enter Email address';
  static const String hintPassword = 'Enter Password';
  static const String hintSkills =
      'Enter done button on keyboard to add Skill.';

  /// error messages
  static const String errorImage = 'Sorry! , Fail to pick image from phone.';
  static const String errorLogout = 'Logout Failed please try again.';
  static const String errorLogIn = 'LogIn Failed!!';
}
