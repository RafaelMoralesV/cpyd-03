import 'dart:convert';

import 'package:cpyd03/screens/meta_screens/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassroomDio {
  static final String url = dotenv.get("X_API_URL");

  static Dio get basicDio => Dio(
        BaseOptions(
          baseUrl: url,
          headers: {'Accept': 'application/json'},
        ),
      );

  static Dio get authDio =>
      basicDio..options.baseUrl = "$url/v1/authentication";

  static Future<Dio> get classroomDio async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');

    return Dio(
      BaseOptions(
        baseUrl: "$url/v1/classroom",
        headers: {
          'Accept': 'application/json',
          'jwt': jwt,
        },
      ),
    );
  }

  /// Intenta hacer LogIn a través de OAuth2.
  static Future<bool> login(context) async {
    var res = await ClassroomDio.authDio.get('/login');

    if (res.statusCode != 200) {
      return false;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthorizationScreen(url: res.data['redirectUrl']),
      ),
    );

    return true;
  }

  static Future<bool> getIn(String classroom, String subject) async {
    Dio dio = await ClassroomDio.classroomDio;

    var params = {
      "classroom": classroom,
      "subject": subject,
      "entrance": _formatedNowString(),
    };

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('classroom', params['classroom']!);
      prefs.setString('subject', params['subject']!);
      prefs.setString('entrance', params['entrance']!);
    });

    var res = await dio.post('/getin', data: jsonEncode(params));
    return res.statusCode == 200;
  }

  static Future<bool> getOut() async {
    Dio dio = await ClassroomDio.classroomDio;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var params = {
      'classroom': prefs.getString('classroom'),
      'subject': prefs.getString('subject'),
      'entrance': prefs.getString('entrance'),
      'leaving': _formatedNowString(),
    };

    var res = await dio.post("/getout", data: jsonEncode(params));
    return res.statusCode == 200;
  }

  static String _formatedNowString({DateTime? dt}) {
    var now = dt ?? DateTime.now();
    var date = DateFormat("yyyy-MM-dd").format(now);
    var time = DateFormat("HH:mm:ss").format(now);

    return "${date}T${time}Z";
  }
}
