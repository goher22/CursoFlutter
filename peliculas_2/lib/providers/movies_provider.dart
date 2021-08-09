import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:peliculas_2/models/movies_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apikey = '677a08d1a6ae1cdf1baa6a5826f4e246';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;

  List<Movie> onDisplayMovie = [];
  List<Movie> onPopularMovie = [];

  MoviesProvider() {
    print("MoviesProvider inicializado");
    getOnDisplayMovie();
    getPopularMovue();
  }

  _getresult(String url, String? page) async {
    var uri = Uri.http(_baseUrl, url, {
      'api_key': _apikey,
      'language': _language,
      'pager': page == null ? '' : page,
    });
    final response = await http.get(uri);
    final decodedData = json.decode(response.body);
    return decodedData['results'];
  }

  getOnDisplayMovie() async {
    final result = await _getresult('3/movie/now_playing', null);
    final movies = Movies.fromJsonList(result);
    this.onDisplayMovie = movies.items;
    notifyListeners();
  }

  getPopularMovue() async {
    _popularesPage++;

    final result = await _getresult(
      '3/movie/popular',
      _popularesPage.toString(),
    );
    final movies = Movies.fromJsonList(result);
    this.onPopularMovie = [...movies.items];
    notifyListeners();
  }
}
