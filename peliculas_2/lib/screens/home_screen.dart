import 'package:flutter/material.dart';
import 'package:peliculas_2/providers/movies_provider.dart';
import 'package:peliculas_2/widgets/card_swiper.dart';
import 'package:peliculas_2/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_outlined,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovie),
            MovieSlider(
              movies: moviesProvider.onPopularMovie,
              title: "Populares",
            ),
          ],
        ),
      ),
    );
  }
}
