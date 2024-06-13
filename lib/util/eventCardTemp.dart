import 'package:flutter/material.dart';

class event_card_temp extends StatelessWidget {
  String? backgroundImageUrl;
  final String EventName;
  final String Date; // New property for the background image
  final String Location;

  event_card_temp({
    Key? key,
    this.backgroundImageUrl,
    required this.EventName,
    required this.Date,
    required this.Location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 208, 8, 68),
                Color.fromARGB(88, 208, 8, 68)
              ]),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(54, 0, 0, 0),
              offset: Offset(5, 5),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
          image: DecorationImage(
              image: NetworkImage(backgroundImageUrl ??
                  'https://www.telecomreviewasia.com/images/stories/2023/06/SLT-MOBITEL_Debuts_New_Operational_Headquarters.jpg'),
              fit: BoxFit.cover,
              opacity: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              EventName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: $Date',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            Text(
              'Location: $Location',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
