import 'dart:convert';

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
  final response = await http
      .get(Uri.parse('http://192.168.1.163:5001/donors/get/$donorID'));

  if (response.statusCode == 200) {
    // Parse the response JSON
    Map<String, dynamic> userData = json.decode(response.body);
    return userData;
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<Map<String, dynamic>> getDonors() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.163:5001/donors/gets'));

  if (response.statusCode == 200) {
    // Parse the response JSON
    Map<String, dynamic> userData = json.decode(response.body);
    return userData;
  } else {
    throw Exception('Failed to load Donors data');
  }
}
