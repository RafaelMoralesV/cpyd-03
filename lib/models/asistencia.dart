import 'package:cpyd03/utils/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Asistencia {
  String classroom;
  String subject;
  String entrance;
  String leaving;
  String email;

  Asistencia({
    required this.classroom,
    required this.subject,
    required this.entrance,
    required this.leaving,
    required this.email,
  });

  factory Asistencia.fromJson(Map<String, dynamic> json) {
    return Asistencia(
      classroom: json['classroom'],
      subject: json['subject'],
      entrance: json['entrance'],
      leaving: json['leaving'],
      email: json['email'],
    );
  }

  static Future<List<Asistencia>> fetchAsistencias() async {
    Dio dio = await ClassroomDio.classroomDio;
    var response = await dio.get("/v1/classroom/attendances");

    if (response.statusCode != 200) {
      throw Error();
    }

    debugPrint(response.data);

    List<dynamic> list = List<dynamic>.from(response.data);
    return List<Asistencia>.from(
      list.map((e) => Asistencia.fromJson(e)).toList(),
    );
  }
}
