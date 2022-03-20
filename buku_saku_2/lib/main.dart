import 'package:buku_saku_2/screens/app/home/detail_angka_kredit_screen.dart';
import 'package:buku_saku_2/screens/app/models/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/introduction_animation/introduction_animation_screen.dart';
import 'package:buku_saku_2/screens/sign_in/create_new_password_screen.dart';
import 'package:buku_saku_2/screens/sign_in/reset_password_screen.dart';
import 'package:buku_saku_2/screens/sign_in/verification_screen.dart';
import 'package:buku_saku_2/screens/sign_in/sign_in_screen.dart';
import 'package:buku_saku_2/screens/sign_in/sign_up_screen.dart';
import 'package:buku_saku_2/screens/app/app_screen.dart';
import 'package:buku_saku_2/screens/app/models/notes_provider.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:buku_saku_2/screens/app/notes/note_detail_screen.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => ScreenProvider()),
      ],
      child: MaterialApp(
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
          VerificationScreen.id: (context) =>
              VerificationScreen("+62899221100"),
          ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
          CreateNewPasswordScreen.id: (context) =>
              const CreateNewPasswordScreen(),

          // Mulai Aplikasinya
          AppScreen.id: (context) => const AppScreen(),
          NoteDetailScreen.id: (context) => const NoteDetailScreen(),
          AddNoteScreen.id: (context) => const AddNoteScreen(),
          DetailAngkaKreditScreen.id: (context) =>
              const DetailAngkaKreditScreen(),
        },
      ),
    );
  }
}
