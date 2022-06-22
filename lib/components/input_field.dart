import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.inputLabel,
    this.isPassword = false,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
  }) : super(key: key);

  final String inputLabel;
  final String? hintText;
  final bool isPassword;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            width: MediaQuery.of(context).size.width,
            child: Text(
              inputLabel,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(100.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(64, 0, 0, 0),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: isPassword,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: const Color.fromARGB(255, 131, 131, 131),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
