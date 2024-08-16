import 'dart:convert';

import 'package:donor2/firebase_options.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FundFlow',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      home: SplashScreen(), // Initial route is the Sign In page
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

class SplashScreen extends StatelessWidget {
  Future<bool> checkTokenValidity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, dynamic> decodedToken = json.decode(
        ascii.decode(
          base64.decode(
            base64.normalize(token.split(".")[1]),
          ),
        ),
      );

      // Check token expiration
      if (decodedToken.containsKey('exp')) {
        int expiryTime = decodedToken['exp'];
        DateTime expiryDate =
            DateTime.fromMillisecondsSinceEpoch(expiryTime * 1000);
        if (expiryDate.isAfter(DateTime.now())) {
          return true; // Token is valid
        }
      }
    }
    return false; // Token is invalid or expired
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkTokenValidity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while checking
        } else {
          if (snapshot.data == true) {
            // Token is valid, navigate to the navbar
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/navbar');
            });
          } else {
            // Token is invalid, navigate to the sign-in page
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/signin');
            });
          }
          return Container(); // Empty container while redirecting
        }
      },
    );
  }
}
