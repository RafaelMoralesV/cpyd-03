import 'dart:math';

import 'package:cpyd03/screens/meta_screens/blank_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<String> _greetings = [
    "Bienvenid@",
    "Que bueno volver a verte",
    "¿Cómo has estado?",
    "¿Cómo te encuentras?",
    "¿Qué tal estás?",
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? greetings;

  @override
  void initState() {
    super.initState();

    greetings = widget._greetings[Random().nextInt(widget._greetings.length)];
  }

  @override
  Widget build(BuildContext context) {
    return BlankCardScreen(
      topWidget: Text(
        greetings ?? "Bienvenid@",
        style: GoogleFonts.inter(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      child: const Text("alo"),
    );
  }
}
