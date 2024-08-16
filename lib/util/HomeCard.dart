import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subTitle; // New property for the background image
  final double width;
  final Color color;

  const HomeCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.width,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
      child: Container(
        width: width,
        height: MediaQuery.of(context).size.height / 7,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 198, 197, 197), Colors.white]),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(54, 0, 0, 0),
              offset: Offset(5, 5),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              subTitle,
              style: TextStyle(
                color: Color.fromARGB(255, 110, 110, 110),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Color.fromARGB(255, 218, 16, 83),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
