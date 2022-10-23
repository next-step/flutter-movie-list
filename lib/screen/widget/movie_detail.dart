import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/bloc/movie_detail_bloc.dart';
import 'package:flutter_movie_list/bloc/src/api_state.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/model/src/movie_detail.dart';

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
    return BlocBuilder<MovieDetailCubit, ApiState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: state is LoadedState
              ? _buildContent(state.data)
              : (state is LoadingState ? _buildLoading() : _buildError()),
        ),
      );
    });
  }

  Widget _buildLoading() {
    return const Center(
      child: Text('Loading...'),
    );
  }

  Widget _buildError() {
    return const Center(
      child: Text('Error'),
    );
  }

  Widget _buildContent(MovieDetail movie) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Image.network('https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {

              if (loadingProgress == null) {
                return child;
              }

              return  SizedBox(
                height: 340,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }),
            SizedBox(
              height: 30,
            ),
            Text(
              movie.title ?? '',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.red),
                SizedBox(
                  width: 10,
                ),
                Text('${movie.voteAverage}' ?? '',
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  width: 10,
                ),
                Text('${movie.releaseDate}' ?? '',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              movie.overview ?? '',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
