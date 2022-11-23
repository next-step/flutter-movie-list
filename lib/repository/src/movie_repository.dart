import 'dart:convert';

import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/model/model.dart'
    show MovieDetail, MovieList;
import 'package:flutter_movie_list/model/src/search_results.dart';

class MovieRepository {
  MovieRepository({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final ApiProvider _apiProvider;

  Future<MovieList> getNotPlaying() async {
    final response = await _apiProvider.get(
      path: 'movie/now_playing',
      parameters: {
        'page': "1",
      },
    );

    return MovieList.fromJson(jsonDecode(response));
  }

  Future<MovieList> getPopular() async {
    final response = await _apiProvider.get(
      path: 'movie/popular',
      parameters: {
        'page': "1",
      },
    );
    //throw ApiLoadingError('error test1');
    return MovieList.fromJson(jsonDecode(response));
  }

  Future<MovieList> getUpcoming() async {
    final response = await _apiProvider.get(
      path: 'movie/upcoming',
      parameters: {
        'page': "1",
      },
    );
    //throw ApiLoadingError('error test2');
    return MovieList.fromJson(jsonDecode(response));
  }

  Future<MovieDetail> getMovieDetail(int id) async {
    final response = await _apiProvider.get(
      path: 'movie/$id',
    );
    return MovieDetail.fromJson(jsonDecode(response));
  }

  Future<SearchResults> search(String query) async {
    final response = await _apiProvider.get(
      path: 'search/movie',
      parameters: {
        'query': query,
      },
    );
    return SearchResults.fromJson(jsonDecode(response));
  }
}

class ApiLoadingError extends Error {
  final String message;

  ApiLoadingError(this.message);

  @override
  String toString() => "ApiLoadingError message: $message";
}
