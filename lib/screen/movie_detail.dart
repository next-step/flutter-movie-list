import 'package:flutter/material.dart';
import 'package:flutter_movie_list/bloc/data_loading.dart';
import 'package:flutter_movie_list/bloc/main_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  final int movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<DetailMovieCubit, DataLoadingState>(
        bloc: DetailMovieCubit(repository: context.read())..load(movieId: widget.movieId),
        builder: (context, state) {
          if (state is LoadedState<DetailMovie>) {
            final movie = state.data;

            return ListView(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                  height: 300,
                  // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  //   if (wasSynchronouslyLoaded) return child;
                  //
                  //   return AnimatedOpacity(
                  //     child: child,
                  //     opacity: frame == null ? 0 : 1,
                  //     duration: Duration(seconds: 2),
                  //     curve: Curves.easeOut,
                  //   );
                  // },
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;

                    return SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_rate,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      movie.voteAverage.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      movie.releaseDate,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        movie.overview,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
