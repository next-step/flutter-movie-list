import 'dart:convert';

import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/model/model.dart';

class SearchRepository {
  SearchRepository({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final ApiProvider _apiProvider;

  Future<MovieList> search({required String query}) async {
    final response = await _apiProvider.get(path: 'search/movie', parameters: {'query': query});

    return MovieList.fromJson(jsonDecode(response));
  }
}