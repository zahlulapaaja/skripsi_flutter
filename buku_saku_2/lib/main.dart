import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/screen_provider.dart';
import 'package:buku_saku_2/screens/app/profile/edit_profile_screen.dart';
import 'package:buku_saku_2/screens/app/profile/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/introduction_animation/introduction_animation_screen.dart';
import 'package:buku_saku_2/screens/app/app_screen.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'screens/app/models/providers/profile_provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => ScreenProvider()),
        ChangeNotifierProvider(create: (_) => DictionaryProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
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
          IntroductionAnimationScreen.id: (context) =>
              const IntroductionAnimationScreen(),

          // Mulai Aplikasinya
          AppScreen.id: (context) => const AppScreen(),
          AddNoteScreen.id: (context) => const AddNoteScreen(),
          SettingScreen.id: (context) => const SettingScreen(),
          EditProfileScreen.id: (context) => const EditProfileScreen(),
        },
      ),
    );
  }
}
