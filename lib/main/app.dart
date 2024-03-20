import 'package:flutter/material.dart';
import 'package:flutter_practical/core/routes/route_config.dart';
import 'package:flutter_practical/core/theme/app_theme.dart';

class App extends StatelessWidget with AppTheme {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Profile',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      routerConfig: RouteConfig().goRouter,
    );
  }
}
