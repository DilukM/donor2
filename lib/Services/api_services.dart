import 'dart:convert';

import 'package:donor2/Services/shared_service.dart';
import 'package:donor2/config.dart';
import 'package:donor2/models/login_request_model.dart';
import 'package:donor2/models/login_response_model.dart';
import 'package:donor2/models/register_request_model.dart';
import 'package:donor2/models/register_response_model.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static var client = http.Client();

  static Future<bool> login(login_request_model model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http('10.0.0.7:4000', Config.loginAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      //Shared
      await SharedService.setLoginDetails(login_Response_Json(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<register_response_model> register(
      register_request_model model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http('10.0.0.7:4000', Config.registerAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return register_Response_Model(response.body);
  }
}
