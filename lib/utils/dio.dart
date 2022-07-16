import 'package:cpyd03/screens/meta_screens/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        baseUrl: url,
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
}
