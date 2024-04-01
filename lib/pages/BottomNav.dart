import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donor2/pages/Leaderboard.dart';
import 'package:donor2/pages/events.dart';
import 'package:donor2/pages/history.dart';
import 'package:donor2/pages/home.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomePage home;
  late LeaderboardPage leaderboard;
  late DonationHistory history;
  late EventPage event;

  @override
  void initState() {
    home = HomePage();
    leaderboard = LeaderboardPage();
    history = DonationHistory();
    event = EventPage();
    pages = [home, leaderboard, history, event];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.white.withOpacity(0),
          color: Color.fromARGB(255, 208, 8, 68),
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.leaderboard_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.history_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.event_available_outlined,
              color: Colors.white,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}
