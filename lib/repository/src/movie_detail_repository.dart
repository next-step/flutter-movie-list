import 'dart:convert';

import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/model/src/movie_detail.dart';

class MovieDetailRepository {
  MovieDetailRepository({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final ApiProvider _apiProvider;

  Future<MovieDetail> getMovieDetail(movieId) async {
    final response = await _apiProvider.get(
      path: 'movie/$movieId',
    );

    return MovieDetail.fromJson(jsonDecode(response));
  }
}
