// enum MovieEvent{
//   nowPlaying,
//   popular,
//   upcoming,
// }

import 'package:bloc/bloc.dart';
import 'package:flutter_movie_list/repository/repository.dart';

import '../model/src/movie.dart';

abstract class MoviesFetchEvent {}

class NowPlayingMoviesFetchEvent extends MoviesFetchEvent {}

class PopularMoviesFetchEvent extends MoviesFetchEvent {}

class UpcomingMoviesFetchEvent extends MoviesFetchEvent {}

class MoviesBloc extends Bloc<MoviesFetchEvent, MovieList> {
  MoviesBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(MovieList.empty) {
    on<NowPlayingMoviesFetchEvent>((event, emit) async {
      emit(await _movieRepository.getNotPlaying());
    });

    on<PopularMoviesFetchEvent>((event, emit) async {
      emit(await _movieRepository.getPopular());
    });

    on<UpcomingMoviesFetchEvent>((event, emit) async {
      emit(await _movieRepository.getUpcoming());
    });
  }

  final MovieRepository _movieRepository;
}
