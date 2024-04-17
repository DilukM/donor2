import 'package:donor2/util/eventCardTemp.dart';
import 'package:flutter/material.dart';

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
  final List<DonationRecord> donationRecords = [
    DonationRecord(
      description: 'Event 1',
      date: DateTime(2022, 2, 1),
      amount: 'Colombo',
      imgURL:
          'https://www.telecomreviewasia.com/images/stories/2023/06/SLT-MOBITEL_Debuts_New_Operational_Headquarters.jpg',
    ),
    DonationRecord(
      description: 'Event 2',
      date: DateTime(2022, 2, 5),
      amount: 'Colombo',
      imgURL:
          'https://www.telecomreviewasia.com/images/stories/2023/06/SLT-MOBITEL_Debuts_New_Operational_Headquarters.jpg',
    ),
    DonationRecord(
      description: 'Event 3',
      date: DateTime(2022, 2, 10),
      amount: 'Colombo',
      imgURL:
          'https://www.telecomreviewasia.com/images/stories/2023/06/SLT-MOBITEL_Debuts_New_Operational_Headquarters.jpg',
    ),
    // Add more hardcoded donation records as needed
  ];
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
              itemCount: donationRecords.length,
              itemBuilder: (context, index) {
                final donation = donationRecords[index];
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    child: event_card_temp(
                        backgroundImageUrl: donation.imgURL,
                        EventName: donation.description,
                        Date: '${donation.date}',
                        Location: donation.amount));
              },
            ),
          ),
        ],
      ),
    );
  }
}
