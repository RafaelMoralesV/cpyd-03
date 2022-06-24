import 'package:cpyd03/screens/meta_screens/blank_screent.dart';
import 'package:flutter/material.dart';

class BlankCardScreen extends StatelessWidget {
  const BlankCardScreen({
    Key? key,
    this.topWidget,
    required this.child,
  }) : super(key: key);

  final Widget? topWidget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlankScreen(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (topWidget != null) topWidget!,
                Container(margin: const EdgeInsets.only(top: 25.0)),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width,
                      child: child,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Center(
                    child: Image.asset(
                      "assets/utem_logo_color_azul.png",
                      height: 70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
