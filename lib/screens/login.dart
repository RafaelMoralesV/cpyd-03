import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: const [
          LoginCarousel(),
        ],
      ),
    );
  }
}

class LoginCarousel extends StatefulWidget {
  const LoginCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginCarousel> createState() => _LoginCarouselState();
}

class _LoginCarouselState extends State<LoginCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final _indexes = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    ColorScheme _scheme = Theme.of(context).colorScheme;

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
                    horizontal: 3.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? _scheme.primary
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
