import 'dart:convert';

import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/model/model.dart';

class SearchRepository {
  SearchRepository({
    required this.provider,
  });

  final ApiProvider provider;

  Future<MovieList> search({required String query}) async {
    final response = await provider.get(path: 'search/movie', parameters: {'query': query});

    return MovieList.fromJson(jsonDecode(response));
  }
}