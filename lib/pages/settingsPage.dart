import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor2/pages/BottomNav.dart';
import 'package:donor2/pages/resetPW.dart';
import 'package:donor2/util/listTile.dart';
import 'package:donor2/util/listTileSettings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

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
        currentUser['avatar'] = userData['avatar'];
        currentUser['id'] = userData['_id'];
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Map<String, dynamic> currentUser = {
    'id': '',
    'rank': 2,
    'name': '',
    'email': '',
    'score': 0,
    'avatar':
        'https://c8.alamy.com/comp/2J3B2T7/3d-illustration-of-smiling-businessman-close-up-portrait-cute-cartoon-man-avatar-character-face-isolated-on-white-background-2J3B2T7.jpg',
  };

  Future<void> updateProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    final fileName = path.basename(file.path);
    print(currentUser['id']);
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(currentUser['id'])
        .child(fileName);

    await storageRef.putFile(file);
    final downloadUrl = await storageRef.getDownloadURL();

    print(downloadUrl);
    final String url =
        'https://esm-deploy-server.vercel.app/donors/update/${currentUser['id']}';

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'avatar': downloadUrl,
      }),
    );

    if (response.statusCode == 200) {
      // Update successful, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }

    setState(() {
      currentUser['avatar'] = downloadUrl;
    });
  }

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
              GestureDetector(
                onTap: () {
                  updateProfileImage();
                },
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(currentUser['avatar']),
                    ),
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
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ResetPasswordPage(donorId: currentUser['id'])));
                  },
                  child: ListTileSettings(
                      title: "Reset Password", icon: Icons.lock)),
              ListTileSettings(title: "Link Facebook", icon: Icons.facebook),
              GestureDetector(
                  onTap: () async {
                    SharedPreferences s = await SharedPreferences.getInstance();
                    await s.remove("token");
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: ListTileSettings(
                      title: "Logout", icon: Icons.exit_to_app)),
            ],
          ),
        ),
      ),
    );
  }
}
