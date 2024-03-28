import 'dart:convert';

login_response_model login_Response_Json(String str) =>
    login_response_model.fromJson(json.decode(str));

class login_response_model {
  String? message;
  Data? data;

  login_response_model({this.message, this.data});

  login_response_model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? username;
  String? email;
  String? date;
  String? id;
  String? token;

  Data({this.username, this.email, this.date, this.id, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    date = json['date'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['date'] = this.date;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}
