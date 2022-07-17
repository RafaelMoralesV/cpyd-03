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

  late Future<Map> _asist;
  bool inClass = false;

  @override
  void initState() {
    super.initState();

    greetings = widget._greetings[Random().nextInt(widget._greetings.length)];

    _asist = changeState();
  }

  Future<Map> changeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      'classroom': prefs.getString('classroom'),
      'subject': prefs.getString('subject'),
      'entrance': prefs.getString('entrance'),
    };
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
          FutureBuilder(
            future: _asist,
            builder: (context, AsyncSnapshot<Map> snapshot) {
              if (!inClass) {
                return const NotInClass();
              }

              return snapshot.hasData
                  ? InClass(classData: snapshot.data!)
                  : const CircularProgressIndicator();
            },
          ),
          const Divider(),
          FutureBuilder(
            future: _asist,
            builder: (context, AsyncSnapshot<Map> snapshot) {
              if (!inClass) {
                return TouchableListItem(
                  title: "Ingresar",
                  description: "Lee el código QR de ingreso para tu clase",
                  icon: Icons.qr_code_scanner,
                  onTap: () => Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRReaderScreen(),
                    ),
                  ).then((bool? inClass) {
                    setState(() {
                      _asist = changeState();
                      inClass = inClass ?? false;
                    });
                  }),
                );
              }

              return snapshot.hasData
                  ? TouchableListItem(
                      icon: Icons.run_circle_outlined,
                      title: "Retirarse",
                      description: "Marcarás tu salida de clase. ¡Adiós!",
                      onTap: () {
                        ClassroomDio.getOut();
                        setState(() {
                          inClass = false;
                        });
                      },
                    )
                  : const CircularProgressIndicator();
            },
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

class InClass extends StatelessWidget {
  const InClass({Key? key, required this.classData}) : super(key: key);

  final Map classData;

  @override
  Widget build(BuildContext context) {
    final String classroom = classData['classroom'];
    final String subject = classData['subject'];
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
            child: Row(
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
                        classroom,
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
                        subject,
                        style: theme.headline3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Center(
              child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              "¡Suerte en tu clase!",
              style: theme.headline3,
            ),
          )),
        ],
      ),
    );
  }
}

class NotInClass extends StatelessWidget {
  const NotInClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Text(
              "No estás presente en ninguna clase ahora mismo...",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Center(
            child: SizedBox(
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
