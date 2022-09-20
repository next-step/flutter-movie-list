import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/model/model.dart' show MovieList;
import 'package:flutter_movie_list/model/src/movie_detail.dart';

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

    return MovieList.fromJson(jsonDecode(response));
  }

  Future<MovieList> getUpcoming() async {
    final response = await _apiProvider.get(
      path: 'movie/upcoming',
      parameters: {
        'page': "1",
      },
    );

    return MovieList.fromJson(jsonDecode(response));
  }

  Future<MovieDetail> getDetail(int id) async {
    final response = await _apiProvider.get(
      path: 'movie/$id',
      parameters: {},
    );

    return MovieDetail.fromJson(jsonDecode(response));
  }
}
