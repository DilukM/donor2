import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<Map<String, dynamic>> leaderboardData = [
    {
      'rank': 1,
      'name': 'John Doe',
      'score': 500,
      'imageUrl':
          'https://thumbs.dreamstime.com/b/unknown-male-avatar-profile-image-businessman-vector-unknown-male-avatar-profile-image-businessman-vector-profile-179373829.jpg'
    },
    {
      'rank': 2,
      'name': 'Jane Smith',
      'score': 450,
      'imageUrl':
          'https://thumbs.dreamstime.com/b/unknown-male-avatar-profile-image-businessman-vector-unknown-male-avatar-profile-image-businessman-vector-profile-179373829.jpg'
    },
    {
      'rank': 3,
      'name': 'Bob Johnson',
      'score': 400,
      'imageUrl':
          'https://thumbs.dreamstime.com/b/unknown-male-avatar-profile-image-businessman-vector-unknown-male-avatar-profile-image-businessman-vector-profile-179373829.jpg'
    },
    {
      'rank': 4,
      'name': 'Bob Johnson',
      'score': 400,
      'imageUrl':
          'https://thumbs.dreamstime.com/b/unknown-male-avatar-profile-image-businessman-vector-unknown-male-avatar-profile-image-businessman-vector-profile-179373829.jpg'
    },
    {
      'rank': 5,
      'name': 'Bob Johnson',
      'score': 400,
      'imageUrl':
          'https://thumbs.dreamstime.com/b/unknown-male-avatar-profile-image-businessman-vector-unknown-male-avatar-profile-image-businessman-vector-profile-179373829.jpg'
    },
  ];

  // Current user data
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
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current user information with profile picture
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(255, 255, 255, 255)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(currentUser['imageUrl'] ?? ''),
                    radius: 70,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Your Rank', style: TextStyle(color: Colors.black)),
                      Text('${currentUser['rank']}',
                          style: TextStyle(
                              color: Colors.red[500],
                              fontSize: 70,
                              fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            // Header row with red background
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  color: const Color.fromARGB(255, 255, 255, 255)),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Rank',
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.bold)),
                  Text('Name',
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.bold)),
                  Text('Score',
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // Leaderboard data with alternating row colors
            Expanded(
              child: ListView.builder(
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: index % 2 == 0 ? Colors.red[100] : Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            leaderboardData[index]['imageUrl'] ?? ''),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(leaderboardData[index]['rank'].toString(),
                              style: TextStyle(color: Colors.red)),
                          Text(leaderboardData[index]['name'] ?? ''),
                          Text(leaderboardData[index]['score'].toString(),
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LeaderboardPage(),
  ));
}
