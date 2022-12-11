import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nursing_home_dexter/ui/intro/page_view.dart';
import 'package:nursing_home_dexter/ui/login/login_screen.dart';
import 'package:nursing_home_dexter/ui/sign_up/sign_up_screen.dart';

import '../../shared/widget/dexter_button.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = "/IntroScreen";

  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const MyPageView(),
          Positioned(
            bottom: 32.0,
            left: 24.0,
            right: 24.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DexterButton(
                      title: "Login",
                      onPress: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      textColor: Colors.white,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DexterButton(
                      title: "Signup",
                      onPress: () {
                        Navigator.of(context).pushNamed(SignupScreen.routeName);
                      },
                      textColor: Colors.white,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
