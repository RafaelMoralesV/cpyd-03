import 'dart:math';

import 'package:cpyd03/components/touchable_list_item.dart';
import 'package:cpyd03/screens/about.dart';
import 'package:cpyd03/screens/meta_screens/blank_card_screen.dart';
import 'package:cpyd03/screens/qr_reader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    super.initState();

    greetings = widget._greetings[Random().nextInt(widget._greetings.length)];
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
          Expanded(
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
          ),
          const Divider(),
          TouchableListItem(
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
            onTap: (() => print("peo 2")),
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
