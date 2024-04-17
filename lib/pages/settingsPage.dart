import 'package:donor2/pages/BottomNav.dart';
import 'package:donor2/util/listTile.dart';
import 'package:donor2/util/listTileSettings.dart';
import 'package:flutter/material.dart';

import '../Services/retrieveUser.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      // Call the function to fetch user data
      Map<String, dynamic> userData = await getUserInfo();

      // Update the currentUser map with the fetched data
      setState(() {
        currentUser['name'] = userData['name'];
        currentUser['email'] = userData['email'];
        currentUser['score'] = userData['score'];
        currentUser['rank'] = userData['rank'];
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Map<String, dynamic> currentUser = {
    'rank': 2,
    'name': '',
    'email': '',
    'score': 0,
    'imageUrl':
        'https://c8.alamy.com/comp/2J3B2T7/3d-illustration-of-smiling-businessman-close-up-portrait-cute-cartoon-man-avatar-character-face-isolated-on-white-background-2J3B2T7.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(currentUser['imageUrl']),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                currentUser['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(currentUser['email']),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 215, 26, 86),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                ),
              ),
              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 30),
              ListTileSettings(title: "Reset Password", icon: Icons.lock),
              ListTileSettings(title: "Link Facebook", icon: Icons.facebook),
              ListTileSettings(title: "Reset Password", icon: Icons.lock),
            ],
          ),
        ),
      ),
    );
  }
}
