import 'package:cpyd03/models/asistencia.dart';
import 'package:cpyd03/screens/meta_screens/blank_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AsistenciaScreen extends StatefulWidget {
  const AsistenciaScreen({Key? key}) : super(key: key);

  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}

class _AsistenciaScreenState extends State<AsistenciaScreen> {
  late Future<List<Asistencia>> asistencias;

  @override
  void initState() {
    super.initState();
    asistencias = Asistencia.fetchAsistencias();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlankCardScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Asistencia Screen",
              style: theme.textTheme.headline1,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: asistencias,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Asistencia>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Text("Hubo un error. Penita!");
                }

                return AsistenciasList(asistencias: snapshot.data!);
              },
            ),
          )
        ],
      ),
    );
  }
}

class AsistenciasList extends StatelessWidget {
  const AsistenciasList({
    Key? key,
    required this.asistencias,
  }) : super(key: key);

  final List<Asistencia> asistencias;

  @override
  Widget build(BuildContext context) {
    Map<String, List<Asistencia>> attMap = {};

    for (var element in asistencias) {
      String key = DateFormat("dd/MM/yyyy").format(element.entrance);

      attMap.putIfAbsent(key, () => []);
      attMap.update(key, (value) => value..add(element));
    }

    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: attMap.length,
        itemBuilder: (context, index) {
          var keys = attMap.keys.toList();

          return AsistenciaPorDiaListView(
            day: keys[index],
            atts: attMap[keys[index]]!,
          );
        },
      ),
    );
  }
}

class AsistenciaPorDiaListView extends StatelessWidget {
  const AsistenciaPorDiaListView({
    Key? key,
    required this.day,
    required this.atts,
  }) : super(key: key);

  final String day;
  final List<Asistencia> atts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: Theme.of(context).textTheme.headline2,
        ),
        Column(
          children: atts
              .map(
                (e) => AsistenciaListItem(
                  asistencia: e,
                  index: atts.indexOf(e),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

class AsistenciaListItem extends StatelessWidget {
  const AsistenciaListItem({
    Key? key,
    required this.asistencia,
    required this.index,
  }) : super(key: key);

  final Asistencia asistencia;
  final int index;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                (index + 1).toString(),
                style: theme.headline3,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Clase:", style: theme.headline3),
                Text(asistencia.subject),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lugar:", style: theme.headline3),
                Text(asistencia.classroom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
