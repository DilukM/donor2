// import 'package:donor/pages/payment_page.dart';
import 'package:donor2/Services/retrieveUser.dart';
import 'package:flutter/material.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

class DonationRecord {
  final String itemName;
  final String date;
  final String quantity;
  final String unit;

  DonationRecord({
    required this.unit,
    required this.itemName,
    required this.date,
    required this.quantity,
  });
}

class DonationHistory extends StatefulWidget {
  const DonationHistory({Key? key}) : super(key: key);

  @override
  _DonationHistoryState createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory> {
  List<DonationRecord> donationRecords = [];

  @override
  void initState() {
    super.initState();
    _fetchDonations();
  }

  void showAlert(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void startOneTimePayment(BuildContext context) async {
    print("Payment function running");
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "merchant_id": "1226825", // Replace your Merchant ID
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "item_number_1": "001",
      "item_name_1": "Test Item #1",
      "amount_1": "5.00",
      "quantity_1": "2",
      "item_number_2": "002",
      "item_name_2": "Test Item #2",
      "amount_2": "20.00",
      "quantity_2": "1",
      "amount": 1000.00,
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("One Time Payment Success. Payment Id: $paymentId");
      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
    }, (error) {
      print("One Time Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("One Time Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  Future<void> _fetchDonations() async {
    try {
      // Fetch the filtered donations
      List<DonationRecord> donations = await getDonations();
      setState(() {
        donationRecords = donations;
      });
    } catch (e) {
      print('Error fetching donations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Donations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Change the corner radius here
                  ),
                  backgroundColor:
                      Color.fromARGB(255, 208, 8, 68), // Background color
                ),
                onPressed: () {
                  startOneTimePayment(context);
                },
                child: Text(
                  'Donate',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Donation History",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: donationRecords.length,
              itemBuilder: (context, index) {
                final donation = donationRecords[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    contentPadding: EdgeInsets.all(8),
                    tileColor: Color.fromARGB(255, 255, 255, 255),
                    title: Text(donation.itemName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Date: ${donation.date.toString()}'),
                    trailing: Text(
                      '${donation.quantity} ${donation.unit}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red[400]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
