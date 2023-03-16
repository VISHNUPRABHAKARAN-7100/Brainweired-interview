import 'dart:convert';
import 'dart:developer';

import 'package:brainwired_interview/home_screen/model/user_model.dart';
import 'package:brainwired_interview/utils/constant_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// This class is home screen provider class.

class HomeScreenProvider with ChangeNotifier {
//  Function to fetch the data from the API
  Future<List<User>> getUsersData() async {
    try {
      var response = await http.get(Uri.parse(ConstantUrls().baseUrl));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final List usersJson = jsonDecode(response.body);
        final users = usersJson.map((e) => User.fromJson(e)).toList();
        return users;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
