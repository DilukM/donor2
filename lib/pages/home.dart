import 'package:donor2/pages/Leaderboard.dart';
import 'package:donor2/pages/history.dart';
import 'package:donor2/util/button.dart';
import 'package:donor2/util/card_temp.dart';
import 'package:donor2/util/listTile.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  //page controller
  final _controller = PageController();

  Map<String, dynamic> currentUser = {
    'rank': 2,
    'name': 'Your Name',
    'score': 480,
    'imageUrl':
        'https://thumbs.dreamstime.com/b/unknown-male-avatar-profile-image-businessman-vector-unknown-male-avatar-profile-image-businessman-vector-profile-179373829.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        //appbar
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Hello!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
        const SizedBox(height: 25),
        //cards
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
          effect: ExpandingDotsEffect(activeDotColor: Colors.grey.shade700),
        ),
        const SizedBox(height: 20),

        //3 buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Button1
            MyButton(
              iconImagePath: 'lib/images/donation.png',
              buttonText: 'Donate',
            ),

            //Button2
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DonationHistory()));
              },
              child: MyButton(
                iconImagePath: 'lib/images/history.png',
                buttonText: 'History',
              ),
            ),

            //Button3
            // MyButton(
            //   iconImagePath: 'lib/images/invoice.png',
            //   buttonText: 'Bills',
            // ),
          ],
        ),

        const SizedBox(height: 35),

        //column -->stats+transactions

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              //statistics

              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaderboardPage()));
                },
                child: listTile(
                  Imgpath: 'lib/images/analysis.png',
                  Title: 'Leader Board',
                  subTitle: 'Check your rank',
                ),
              ),

              //transaction
              listTile(
                Imgpath: 'lib/images/transaction.png',
                Title: 'Upcoming Events',
                subTitle: 'Keep in touch with us',
              ),
            ],
          ),
        ),
      ]),
    ));
  }

  Future<void> _launchFacebookURL() async {
    if (!await launchUrl(Uri.parse('https://www.facebook.com/'))) {
      throw Exception('Could not launch url');
    }
  }
}
