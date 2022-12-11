import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nursing_home_dexter/routes/generated_routes.dart';
import 'package:nursing_home_dexter/shared/app_constants/app_colors.dart';
import 'package:nursing_home_dexter/shared/app_constants/app_constant.dart';
import 'package:nursing_home_dexter/shared/app_constants/custom_theme.dart';
import 'package:nursing_home_dexter/ui/splash/splash_screen.dart';

import 'bloc/main_bloc_observer.dart';
import 'firebase_options.dart';

DateFormat dateFormat = DateFormat('d-M-y');
// .format(now);// 28/03/2020


void customFloatingSnackBar(
    {required BuildContext context, required String content, bool isSuccess = true}) {
  SnackBar? floatingSnackBar = SnackBar(
    content: Text(
      content,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.white,


        fontSize: 14,
      ),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    backgroundColor: isSuccess ? AppColors.green : AppColors.mainAppColor,
    elevation: 1,
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(floatingSnackBar);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MainBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        onGenerateRoute: GenerateRoutes.generateRoute,
        locale: const Locale('en', 'US'),
        // initialRoute: SplashScreen.splash,
        home: SplashScreen());
  }
}
