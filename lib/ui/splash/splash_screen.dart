import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/splash_bloc/splash_bloc.dart';
import '../../shared/utils/size_config.dart';
import '../home/home_screen.dart';
import '../intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/IntroScreen";

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashBloc bloc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider<SplashBloc>(
      create: (context) {
        bloc = SplashBloc();
        bloc.add(AppStartEvent());
        return bloc;
      },
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (BuildContext ctx, state) async {
          if (state is SplashAuthenticatedState) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          } else if (state is SplashUnAuthenticatedState) {
            Navigator.of(context).pushReplacementNamed(IntroScreen.routeName);
          }
        },
        builder: (BuildContext ctx, state) {
          return buildMaterialLayout();
        },
      ),
    );
  }

  Material buildMaterialLayout() {
    return Material(
      color: Colors.white,
      child: Center(
        child: SvgPicture.asset('assets/images/dexter_logo.svg', semanticsLabel: 'Acme Logo'),
      ),
    );
  }

// void initAppComponent(BuildContext context) {
//   if (appComponent.height == null) {
//     final query = MediaQuery.of(context);
//     appComponent.hasNotch = query.viewPadding.bottom > 20;
//     appComponent.height = query.size.height;
//     appComponent.padding = query.padding.top;
//     appComponent.width = query.size.width;
//     appComponent.heightFinal = MediaQuery.of(context).size.height -
//         AppBar().preferredSize.height -
//         MediaQuery.of(context).viewPadding.top;
//     try {
//       appComponent.brightness = Brightness.light;
//       // appComponent.brightness = MediaQuery.platformBrightnessOf(context);
//     } catch (e) {
//       appComponent.brightness = Brightness.light;
//     }
//   }
// }
}
