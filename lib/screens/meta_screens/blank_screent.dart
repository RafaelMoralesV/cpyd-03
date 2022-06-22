import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlankScreen extends StatelessWidget {
  const BlankScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/banner.svg",
            width: MediaQuery.of(context).size.width,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: child,
          )),
        ],
      ),
    );
  }
}
