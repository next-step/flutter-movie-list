import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

abstract class MovieListEvent {}

class LoadMoviesEvent extends MovieListEvent {}

class ChangeIndexEvent extends MovieListEvent {
  final int index;
  ChangeIndexEvent(this.index);
}

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository repository;

  MovieListBloc({
    required this.repository,
  }) : super(MovieListState()) {
    on<LoadMoviesEvent>((event, emit) async {
      final movieList = await repository.getNotPlaying();

      emit(MovieListState(movies: movieList.results, currentIndex: state.currentIndex));
    });

    on<ChangeIndexEvent>((event, emit) {
      emit(MovieListState(movies: state.movies, currentIndex: event.index));
    });

    add(LoadMoviesEvent());
  }
}

class MovieListState {
  final List<Movie> movies;
  final int currentIndex;

  MovieListState({
    this.movies = const [],
    this.currentIndex = 0,
  });
}
