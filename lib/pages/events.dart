import 'dart:convert';

import 'package:donor2/util/eventCardTemp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DonationRecord {
  final String description;
  final DateTime date;
  final String amount;
  final String imgURL;

  DonationRecord({
    required this.description,
    required this.date,
    required this.amount,
    required this.imgURL,
  });
}

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Map<String, dynamic>> eventsData = [];

  Future<void> _fetcheventsData() async {
    final url = 'https://esm-deploy-server.vercel.app/donorevents/gets';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          eventsData =
              data.map((item) => item as Map<String, dynamic>).toList();
        });
      } else {
        print('Failed to load event data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching event data: $e');
    }
  }

  @override
  void initState() {
    _fetcheventsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Events',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: eventsData.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    child: event_card_temp(
                        backgroundImageUrl: '${eventsData[index]['cover']}',
                        EventName: eventsData[index]['eventName'].toString(),
                        Date: '${eventsData[index]['date']}',
                        Location: '${eventsData[index]['location']}'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
