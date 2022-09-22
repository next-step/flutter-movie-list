import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/api/src/api_provider.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:flutter_movie_list/screen/search/search_bloc.dart';
import 'package:flutter_movie_list/screen/search/search_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(repository: MovieRepository(apiProvider: ApiProviderImpl())),
      child: const SearchPage(),
    );
  }
}
