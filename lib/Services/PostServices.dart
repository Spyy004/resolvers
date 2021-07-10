import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:resolvers/Models/ExistingUserModel.dart';
import 'package:resolvers/Models/NewUserModel.dart';
import 'package:flutter/material.dart';
import 'package:resolvers/Services/SharedPreferences.dart';
class PostServices {
 Future<NewUser> createNewUser(String username, String email, String password) async
  {
    Uri uri = Uri.parse("https://ashish226.pythonanywhere.com/api/register/");
    var head = {
      "Content-Type":"application/json"
    };
    var user = {
      "username": username,
      "email": email,
      "password": password
    };
    var response = await http.post(
        uri,
        headers: head,
        body: jsonEncode(user),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      print("User Registered:");
      print(response.body);
      Fluttertoast.showToast(msg: "User created successfully");
      return NewUser.fromJson(jsonDecode(response.body));
    }
    else {
      print(response.statusCode);
      print(response.body);
      Fluttertoast.showToast(msg: response.body);
      return null;
    }
  }
 Future<ExistingUser> LogInUser(String username,String password)async
  {
    Uri uri = Uri.parse("https://ashish226.pythonanywhere.com/api/login/");
    var user = {
      "username": username,
      "password": password
    };
    var head = {
      "Content-Type":"application/json"
    };
    var response = await http.post(
      uri,
      body: jsonEncode(user),
      headers: head
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      print("User LoggedIn:");
      print(response.body);
      Fluttertoast.showToast(msg:"User Logged In successfully");
      var x = jsonDecode(response.body);
      saveToken(saveKey: "token1",saveValue: x["token"]);
      return ExistingUser.fromJson(jsonDecode(response.body));
    }
    else {
      print(response.statusCode);
      print(response.body);
      Fluttertoast.showToast(msg: response.body);
      return null;
    }
  }
}