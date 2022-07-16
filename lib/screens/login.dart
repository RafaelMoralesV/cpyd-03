import 'package:carousel_slider/carousel_slider.dart';
import 'package:cpyd03/components/button.dart';
import 'package:cpyd03/components/input_field.dart';
import 'package:cpyd03/utils/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(
          children: [
            const LoginCarousel(),
            const AppBanner(),
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 50,
                  child: SignInButton(
                    Buttons.Google,
                    onPressed: () => ClassroomDio.login(context),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    text: "Ingresar con correo Utem",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(25.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.asset("assets/utem_logo_color_azul.png"),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Get-IN Utem",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "App de Ingreso a Clases",
                textAlign: TextAlign.left,
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class LoginCarousel extends StatefulWidget {
  const LoginCarousel({Key? key}) : super(key: key);

  @override
  State<LoginCarousel> createState() => _LoginCarouselState();
}

class _LoginCarouselState extends State<LoginCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final _indexes = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: _indexes
              .map(
                (index) => Image.asset(
                  "assets/carousel/$index.jpg",
                  cacheHeight: 500,
                  fit: BoxFit.fill,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 300.0,
            viewportFraction: 1,
            pageSnapping: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            autoPlayCurve: Curves.ease,
            clipBehavior: Clip.hardEdge,
            onPageChanged: (index, reason) => setState(
              () => _current = index,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _indexes.asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 5.0,
                  height: 5.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 1.5,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? scheme.primary
                        : Colors.grey[800],
                  ),
                ),
              );
            },
          ).toList(),
        )
      ],
    );
  }
}
