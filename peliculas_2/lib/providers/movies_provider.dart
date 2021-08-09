import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:peliculas_2/models/movies_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apikey = '677a08d1a6ae1cdf1baa6a5826f4e246';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovie = [];

  MoviesProvider() {
    print("MoviesProvider inicializado");
    getOnDisplayMovie();
  }
  getOnDisplayMovie() async {
    var url = Uri.http(_baseUrl, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final movies = Movies.fromJsonList(decodedData['results']);
    this.onDisplayMovie = movies.items;
    notifyListeners();
  }
}
