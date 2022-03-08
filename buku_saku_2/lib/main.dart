import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/app_screen.dart';
import 'package:buku_saku_2/screens/app/dictionary/detail_screen.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:buku_saku_2/screens/app/notes/note_detail_screen.dart';
// import 'package:buku_saku_2/screens/app/home.dart';
import 'package:buku_saku_2/screens/sign_in/create_new_password_screen.dart';
import 'package:buku_saku_2/screens/sign_in/reset_password_screen.dart';
import 'package:buku_saku_2/screens/sign_in/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/introduction_animation/introduction_animation_screen.dart';
import 'package:buku_saku_2/screens/sign_in/sign_in_screen.dart';
import 'package:buku_saku_2/screens/sign_in/sign_up_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Saku Prakom',
      navigatorKey: navigatorKey,
      theme: Theme.of(context).copyWith(
        // Define the default colors
        primaryColor: AppColors.primary,

        scaffoldBackgroundColor: Colors.transparent,
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
        DetailScreen.id: (context) => DetailScreen(),
        NoteDetailScreen.id: (context) => NoteDetailScreen(),
        AddNoteScreen.id: (context) => AddNoteScreen(),
      },
    );
  }
}
