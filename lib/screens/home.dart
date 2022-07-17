import 'dart:math';

import 'package:cpyd03/components/touchable_list_item.dart';
import 'package:cpyd03/screens/about.dart';
import 'package:cpyd03/screens/asistencia.dart';
import 'package:cpyd03/screens/meta_screens/blank_card_screen.dart';
import 'package:cpyd03/screens/qr_reader.dart';
import 'package:cpyd03/utils/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<String> _greetings = [
    "¡Bienvenide!",
    "¡Qué bueno volver a verte!",
    "¿Cómo has estado?",
    "¿Cómo te encuentras?",
    "¿Qué tal estás?",
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String greetings;

  String? classroom;
  String? subject;
  String? entrance;

  @override
  void initState() {
    super.initState();

    greetings = widget._greetings[Random().nextInt(widget._greetings.length)];

    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      classroom = prefs.getString('classroom');
      subject = prefs.getString('subject');
      entrance = prefs.getString('entrance');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlankCardScreen(
      topWidget: Text(
        greetings,
        style: GoogleFonts.inter(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      child: Column(
        children: [
          InfoClaseActual(
            classroom: classroom,
            subject: subject,
            entrance: entrance,
          ),
          const Divider(),
          classroom != null
              ? TouchableListItem(
                  icon: Icons.run_circle_outlined,
                  title: "Retirarse",
                  description: "Marcarás tu salida de clase. ¡Adiós!",
                  onTap: () {
                    ClassroomDio.getOut();
                    setState(() {
                      classroom = null;
                      subject = null;
                      entrance = null;
                    });
                  },
                )
              : TouchableListItem(
                  title: "Ingresar",
                  description: "Lee el código QR de ingreso para tu clase",
                  icon: Icons.qr_code_scanner,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRReaderScreen(),
                    ),
                  ),
                ),
          const Divider(),
          TouchableListItem(
            title: "Asistencia",
            description: "Revisa tu asistencia a clases",
            icon: Icons.supervised_user_circle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const AsistenciaScreen()),
              ),
            ),
          ),
          const Divider(),
          TouchableListItem(
            title: "Sobre la App",
            description: "Revisa detalles sobre esta App",
            icon: Icons.laptop_chromebook,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class InfoClaseActual extends StatelessWidget {
  const InfoClaseActual({
    Key? key,
    this.classroom,
    this.subject,
    this.entrance,
  }) : super(key: key);

  final String? classroom;
  final String? subject;
  final String? entrance;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Clase actual",
            style: Theme.of(context).textTheme.headline1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: classroom != null
                ? Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Salón:",
                              style: theme.headline2,
                            ),
                            Text(
                              classroom!,
                              style: theme.headline3,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Código:",
                              style: theme.headline2,
                            ),
                            Text(
                              subject!,
                              style: theme.headline3,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Text(
                    "No estás presente en ninguna clase ahora mismo...",
                    style: Theme.of(context).textTheme.headline3,
                  ),
          ),
          Center(
            child: classroom != null
                ? Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      "¡Suerte en tu clase!",
                      style: theme.headline3,
                    ),
                  )
                : SizedBox(
                    width: 75,
                    height: 50,
                    child: Image.asset(
                      'assets/moon.png',
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
