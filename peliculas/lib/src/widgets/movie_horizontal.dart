import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula>? peliculas;
  final _pageConreoller = PageController(initialPage: 1, viewportFraction: 0.3);
  final Function? siguentePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguentePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageConreoller.addListener(() {
      if (_pageConreoller.position.pixels >=
          _pageConreoller.position.maxScrollExtent - 200) {
        siguentePagina!();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageConreoller,
        itemCount: peliculas!.length,
        itemBuilder: (context, i) => _crearTarjeta(context, peliculas![i]),
        //children: _tarjetas(context),
      ),
    );
  }

  Widget _crearTarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniquedId = '${pelicula.id}-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniquedId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.gerPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
        child: tarjeta);
  }
}
