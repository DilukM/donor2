import 'package:donor2/pages/BottomNav.dart';
import 'package:donor2/pages/Leaderboard.dart';
import 'package:donor2/pages/events.dart';
import 'package:donor2/pages/history.dart';
import 'package:donor2/pages/home.dart';
import 'package:donor2/pages/profile.dart';
import 'package:donor2/pages/settingsPage.dart';
import 'package:donor2/pages/signUpPage.dart';
import 'package:donor2/pages/signinPage.dart';

import 'package:donor2/util/MongoDB.dart';
import 'package:donor2/util/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manusath Derana',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      initialRoute: '/signin', // Initial route is the Sign In page
      routes: {
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/navbar': (context) => const BottomNav(),
        '/leaderboard': (context) => LeaderboardPage(),
        '/history': (context) => const DonationHistory(),
        '/events': (context) => const EventPage(),
        '/settings': (context) => const SettingsPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
