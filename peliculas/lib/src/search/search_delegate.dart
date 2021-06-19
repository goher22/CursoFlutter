import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final peliculaprovider = PeliculasProvider();

  // final peliculas = [
  //   'Spiderman',
  //   'Aquaman',
  //   'Batman',
  //   'Shazam!',
  //   'Iroman',
  //   'Capitan America'
  // ];

  // final peliculasRecientes = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las Acciones de nuestro AppBar
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la Izquierda del AppBar
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultado que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencia que aparencen cuando escriben
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculaprovider.buscarPelicula(query),
      builder: (BuildContext contex, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas!.map((p) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(p.gerPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
                title: Text(p.title.toString()),
                subtitle: Text(p.originalTitle.toString()),
                onTap: () {
                  close(context, null);
                  p.uniquedId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: p);
                },
              );
            }).toList() as List<Widget>,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencia que aparencen cuando escriben

  //   final listaSugeridad = (query.isEmpty)
  //       ? peliculasRecientes
  //       : peliculas
  //           .where((element) =>
  //               element.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //     itemCount: listaSugeridad.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugeridad[i]),
  //         onTap: () {
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
}
