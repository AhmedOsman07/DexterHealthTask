import 'package:flutter/material.dart';
import 'package:nursing_home_dexter/ui/intro/intro_screen.dart';
import 'package:nursing_home_dexter/ui/splash/splash_screen.dart';

import '../ui/add_todo/add_todo.dart';
import '../ui/home/home_screen.dart';
import '../ui/login/login_screen.dart';
import '../ui/sign_up/sign_up_screen.dart';

class GenerateRoutes {
  static MaterialPageRoute _goTo(Widget screen, settings) =>
      MaterialPageRoute(settings: settings, builder: (context) => screen);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case LoginScreen.routeName:
        return _goTo(const LoginScreen(), settings);
      case AddTodoItemScreen.routeName:
        return _goTo(const AddTodoItemScreen(), settings);
      case SignupScreen.routeName:
        return _goTo(const SignupScreen(), settings);
      case HomeScreen.routeName:
        return _goTo(const HomeScreen(), settings);
      case IntroScreen.routeName:
        return _goTo(
          const IntroScreen(),
          settings,
        );
      default:
        return _goTo(SplashScreen(), settings);
    }
  }
}
