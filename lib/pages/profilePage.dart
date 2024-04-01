import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const Profile());
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manusath Derana',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            color: Color.fromARGB(255, 237, 237, 237)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 237, 237, 237),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 216, 64, 53)),
        useMaterial3: true,
      ),
      home: const MyWidget(),
      // Initial route is the Sign In page
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
                  child: const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('lib/images/project.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Text("Email"),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 128, 16, 8),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                ),
              ),
              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
