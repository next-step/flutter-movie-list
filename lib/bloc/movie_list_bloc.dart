import 'package:bloc/bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

abstract class MovieListEvent {}

class LoadMoviesEvent extends MovieListEvent {}

class MovieListBloc extends Bloc<MovieListEvent, MovieList> {
  final MovieRepository repository;

  MovieListBloc({
    required this.repository,
  }) : super(MovieList()) {
    on<LoadMoviesEvent>((event, emit) async {
      final movieList = await repository.getNotPlaying();

      emit(movieList);
    });
  }
}
