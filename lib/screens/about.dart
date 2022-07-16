import 'package:cpyd03/components/touchable_list_item.dart';
import 'package:cpyd03/screens/meta_screens/blank_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return BlankCardScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sobre la App", style: textTheme.headline1),
          const SizedBox(height: 10.0),
          Text("Grupo G", style: textTheme.headline2),
          const SizedBox(height: 20.0),
          const Integrante(
            image: "rmorales",
            name: "Rafael Morales Venegas",
            about:
                "Me gustó mucho el diseño que logré en esta App, es la primera vez que me sale uno bonito",
          ),
          const SizedBox(height: 20.0),
          const Integrante(
            image: "doyarce",
            name: "Diego Oyarce Trejo",
            about:
                "Me lesioné como 2 veces en lo que va el semestre. Vamos por una tercera.",
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 1.0),
          const SizedBox(height: 10.0),
          Text("Repositorio de la Aplicación", style: textTheme.headline2),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TouchableListItem(
              icon: Icons.link,
              title: "Github",
              description: "Puedes encontrar el código en este sitio",
              onTap: () async => await launchUrlString(
                "https://github.com/RafaelMoralesV/cpyd-03",
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 1.0),
          const SizedBox(height: 10.0),
          Text(
            "Sobre la Asignatura",
            style: textTheme.headline2,
          ),
          Text(
            "Computación paralela y distribuída",
            style: textTheme.headline3,
          ),
          Text(
            "Profesor Sebastián Salazar Molina",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "Primer Semestre 2022",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 1.0),
          const SizedBox(height: 10.0),
          Text(
            "Agradecimientos",
            style: textTheme.headline2,
          ),
          Text(
            "Jeswin Thomas, Van Tay Media y Wes Hicks por las fotos utilizadas.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class Integrante extends StatelessWidget {
  const Integrante({
    Key? key,
    required this.image,
    required this.name,
    required this.about,
  }) : super(key: key);

  final String image;
  final String name;
  final String about;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: Image.asset("assets/about/$image.png"),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 20.0,
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 60.0,
                  child: Text(
                    about,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
