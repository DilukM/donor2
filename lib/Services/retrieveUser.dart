import 'dart:convert';

import 'package:donor2/pages/history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String? donorID;

  if (token != null && token.isNotEmpty) {
    Map<String, dynamic> decodedToken = json.decode(
      ascii.decode(
        base64.decode(
          base64.normalize(token.split(".")[1]),
        ),
      ),
    );

    if (decodedToken.containsKey('donorId')) {
      var currentUser = decodedToken['donorId'];
      donorID = currentUser;
    }
  }
  // Make an HTTP request to fetch user data based on the userId
  final response = await http.get(
      Uri.parse('https://esm-deploy-server.vercel.app/donors/get/$donorID'));

  if (response.statusCode == 200) {
    // Parse the response JSON
    Map<String, dynamic> userData = json.decode(response.body);
    return userData;
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<Map<String, dynamic>> getDonors() async {
  final response = await http
      .get(Uri.parse('https://esm-deploy-server.vercel.app/donors/gets'));

  if (response.statusCode == 200) {
    // Parse the response JSON
    Map<String, dynamic> userData = json.decode(response.body);
    return userData;
  } else {
    throw Exception('Failed to load Donors data');
  }
}

Future<List<DonationRecord>> getDonations() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String? donorID;

  if (token != null && token.isNotEmpty) {
    Map<String, dynamic> decodedToken = json.decode(
      ascii.decode(
        base64.decode(
          base64.normalize(token.split(".")[1]),
        ),
      ),
    );

    if (decodedToken.containsKey('donorId')) {
      var currentUser = decodedToken['donorId'];
      donorID = currentUser;
    }
  }
  // Make an HTTP request to fetch user data based on the userId
  final response = await http
      .get(Uri.parse("https://esm-deploy-server.vercel.app/items_in/gets"));

  if (response.statusCode == 200) {
    // Parse the response JSON
    List<dynamic> donationsList = json.decode(response.body);

    // Filter the donations based on the donorId
    List<DonationRecord> filteredDonations = donationsList
        .where((donation) => donation['donorId'] == donorID)
        .map((donation) => DonationRecord(
              unit: donation['unit'] ?? '',
              itemName: donation['itemName'] ?? '',
              date: donation['date'] ?? '',
              quantity: donation['quantity'] ?? '',
            ))
        .toList();

    return filteredDonations;
  } else {
    throw Exception('Failed to load donations data');
  }
}

Future<double> getTotalCashDonations() async {
  // Fetch all donations
  List<DonationRecord> donations = await getDonations();

  // Filter donations where itemName is "cash"
  List<DonationRecord> cashDonations = donations
      .where((donation) => donation.itemName.toLowerCase() == 'cash')
      .toList();

  // Calculate the total amount of cash donations
  double totalAmount = cashDonations.fold(0.0, (sum, donation) {
    return sum + (double.tryParse(donation.quantity) ?? 0.0);
  });

  return totalAmount;
}
