import 'package:cpyd03/models/asistencia.dart';
import 'package:cpyd03/screens/meta_screens/blank_card_screen.dart';
import 'package:flutter/material.dart';

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
          FutureBuilder(
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

              return SizedBox(
                height: 600,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Text(snapshot.data![index].entrance);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
