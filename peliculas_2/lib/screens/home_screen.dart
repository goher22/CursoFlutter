import 'package:flutter/material.dart';
import 'package:peliculas_2/widgets/card_swiper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          CardSwiper(),
        ],
      ),
    );
  }
}
