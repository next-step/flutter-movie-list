import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/bloc/movie_search_bloc.dart';

import '../repository/src/movie_repository.dart';

part 'widget/search/search_field.dart';
part 'widget/search/search_result_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchBloc =
        MovieSearchBloc(repository: context.read<MovieRepository>());
    return BlocProvider<MovieSearchBloc>(
      create: (context) => searchBloc,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: _SearchField(),
          ),
        ),
        body: const _SearchResultList(),
      ),
    );
  }
}
