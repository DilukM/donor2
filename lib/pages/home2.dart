import 'dart:async';

import 'package:donor2/pages/BottomNav.dart';
import 'package:donor2/reusable_widgets/circular_container.dart';
import 'package:donor2/reusable_widgets/curved_edges.dart';
import 'package:donor2/util/card_temp.dart';
import 'package:donor2/util/listTile.dart';
import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _Home2State();
}

class _Home2State extends State<HomePage2> {
  final _controller = PageController();
  late Timer _timer;
  int _currentPage = 0;

  Map<String, dynamic> currentUser = {
    'rank': 2,
    'name': 'Diluk Mihiranga',
    'email': 'diluk@gmail.com',
    'score': 480,
    'imageUrl':
        'https://c8.alamy.com/comp/2J3B2T7/3d-illustration-of-smiling-businessman-close-up-portrait-cute-cartoon-man-avatar-character-face-isolated-on-white-background-2J3B2T7.jpg',
  };
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Container(
                color: Color.fromARGB(255, 208, 8, 68),
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 250,
                  child: Stack(children: [
                    Positioned(
                        top: -150,
                        right: -250,
                        child: TCircularContainer(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.1))),
                    Positioned(
                        top: 100,
                        right: -300,
                        child: TCircularContainer(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.1))),
                  ]),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hello!",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),

                  //share button
                  GestureDetector(
                    onTap: () {
                      _launchFacebookURL();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 208, 8, 68),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              left: 15,
              width: 380,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(colors: <Color>[
                      Color.fromARGB(100, 255, 255, 255),
                      Color.fromARGB(25, 255, 255, 255),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      foregroundImage:
                          NetworkImage(currentUser['imageUrl'] ?? ''),
                      radius: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${currentUser['name']}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text('Email: ${currentUser['email']}',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold)),
                        Text('Score: ${currentUser['score']}',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ).asGlass(
                tintColor: Colors.transparent,
                clipBorderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      children: [
                        card_temp(
                          backgroundImageUrl:
                              'https://www.telecomreviewasia.com/images/stories/2023/06/SLT-MOBITEL_Debuts_New_Operational_Headquarters.jpg',
                        ),
                        card_temp(
                          backgroundImageUrl:
                              'https://cdn.shortpixel.ai/spai/w_767+q_lossy+ret_img+to_webp/https://i0.wp.com/srilankatelecom.com/wp-content/uploads/2022/12/Dialog-Unlimited-Blaster-Package.jpg?fit=1024%2C576&ssl=1',
                        ),
                        card_temp(
                          backgroundImageUrl:
                              'https://cdn.shortpixel.ai/spai/w_767+q_lossy+ret_img+to_webp/https://i0.wp.com/srilankatelecom.com/wp-content/uploads/2022/12/Dialog-Unlimited-Blaster-Package.jpg?fit=1024%2C576&ssl=1',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        activeDotColor: Color.fromARGB(255, 208, 8, 68)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => BottomNav()));
                    },
                    child: listTile(
                      Imgpath: 'lib/images/analysis.png',
                      Title: 'Notification',
                      subTitle: 'Lorem Ipsum is simply dummy...',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => BottomNav()));
                    },
                    child: listTile(
                      Imgpath: 'lib/images/analysis.png',
                      Title: 'Notification',
                      subTitle: 'Lorem Ipsum is simply dummy...',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => BottomNav()));
                    },
                    child: listTile(
                      Imgpath: 'lib/images/analysis.png',
                      Title: 'Notification',
                      subTitle: 'Lorem Ipsum is simply dummy...',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => BottomNav()));
                    },
                    child: listTile(
                      Imgpath: 'lib/images/analysis.png',
                      Title: 'Notification',
                      subTitle: 'Lorem Ipsum is simply dummy...',
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  Future<void> _launchFacebookURL() async {
    if (!await launchUrl(Uri.parse('https://www.facebook.com/'))) {
      throw Exception('Could not launch url');
    }
  }
}
