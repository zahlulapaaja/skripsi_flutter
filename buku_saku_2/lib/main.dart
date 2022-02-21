import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/app_screen.dart';
// import 'package:buku_saku_2/screens/app/home.dart';
import 'package:buku_saku_2/screens/sign_in/create_new_password_screen.dart';
import 'package:buku_saku_2/screens/sign_in/reset_password_screen.dart';
import 'package:buku_saku_2/screens/sign_in/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/introduction_animation/introduction_animation_screen.dart';
import 'package:buku_saku_2/screens/sign_in/sign_in_screen.dart';
import 'package:buku_saku_2/screens/sign_in/sign_up_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Saku Prakom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: AppColors.primary,
        textTheme:
            Theme.of(context).textTheme.apply(bodyColor: AppColors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppScreen.id,
      routes: {
        SignInScreen.id: (context) => const SignInScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        IntroductionAnimationScreen.id: (context) =>
            IntroductionAnimationScreen(),
        VerificationScreen.id: (context) => VerificationScreen("+62899221100"),
        ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
        CreateNewPasswordScreen.id: (context) => CreateNewPasswordScreen(),

        // Mulai Aplikasinya
        AppScreen.id: (context) => AppScreen(),
      },
    );
  }
}
