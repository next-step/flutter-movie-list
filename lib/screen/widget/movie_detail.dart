import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/bloc/movie_detail_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';

class MovieDetailWidgetArgument {
  Movie movie;

  MovieDetailWidgetArgument({required this.movie});
}

class MovieDetailWidget extends StatefulWidget {
  static const routeName = '/movieDetail';

  final Movie movie;

  const MovieDetailWidget({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailWidget> createState() =>
      _MovieDetailWidgetState(movieId: movie.id);
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  final int movieId;

  _MovieDetailWidgetState({required this.movieId});

  @override
  void initState() {
    super.initState();

    context.read<MovieDetailCubit>().loadWithParam(movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('$movieId'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
