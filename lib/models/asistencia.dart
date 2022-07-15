import 'package:dio/dio.dart';
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
    final API = dotenv.get("X_API_URL");
    final response = await Dio(
      BaseOptions(
        headers: {
          'jwt': "JWT",
          'Accept': 'application/json',
        },
      ),
    ).get("$API/v1/classroom/attendances");

    if (response.statusCode != 200) {
      return Future.value([]);
    }

    List<dynamic> list = List<dynamic>.from(response.data);
    return List<Asistencia>.from(
      list.map((e) => Asistencia.fromJson(e)).toList(),
    );
  }
}
