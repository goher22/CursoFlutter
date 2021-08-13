import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:peliculas_2/helpers/debouncer.dart';
import 'package:peliculas_2/models/actor_response.dart';
import 'package:peliculas_2/models/movies_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apikey = '677a08d1a6ae1cdf1baa6a5826f4e246';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;

  List<Movie> onDisplayMovie = [];
  List<Movie> onPopularMovie = [];

  Map<int, List<Actor>> moviesCast = {};

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

  MoviesProvider() {
    print("MoviesProvider inicializado");
    getOnDisplayMovie();
    getPopularMovue();
  }

  _getresult(Uri uri) async {
    final response = await http.get(uri);
    final decodedData = json.decode(response.body);
    return decodedData['results'];
  }

  getOnDisplayMovie() async {
    var uri = Uri.http(_baseUrl, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});
    final result = await _getresult(uri);
    final movies = Movies.fromJsonList(result);
    this.onDisplayMovie = movies.items;
    notifyListeners();
  }

  getPopularMovue() async {
    _popularesPage++;

    var uri = Uri.http(_baseUrl, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final result = await _getresult(uri);
    final movies = Movies.fromJsonList(result);
    this.onPopularMovie = [...onPopularMovie, ...movies.items];
    notifyListeners();
  }

  Future<List<Movie>> getSearchMovie(String shearMovie) async {
    var uri = Uri.http(_baseUrl, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': shearMovie,
    });

    final result = await _getresult(uri);
    final movies = Movies.fromJsonList(result);
    return movies.items;
  }

  Future<List<Actor>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    var uri = Uri.http(_baseUrl, '3/movie/$movieId/credits',
        {'api_key': _apikey, 'language': _language});
    final resp = await http.get(uri);
    final decodedData = json.decode(resp.body);
    final credit = Cast.fromJsonList(decodedData['cast']);
    moviesCast[movieId] = credit.actores;
    return credit.actores;
  }

  void getSuggerstionByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.getSearchMovie(value);
      this._suggestionStreamController.add(results);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
