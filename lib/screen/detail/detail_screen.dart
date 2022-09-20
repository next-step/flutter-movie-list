import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/api/src/api_provider.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:flutter_movie_list/screen/detail/detail_bloc.dart';
import 'package:flutter_movie_list/screen/detail/detail_page.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required int id})
      : _id = id,
        super(key: key);

  final int _id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailBloc(repository: MovieRepository(apiProvider: ApiProviderImpl())),
      child: DetailPage(id: widget._id),
    );
  }
}
