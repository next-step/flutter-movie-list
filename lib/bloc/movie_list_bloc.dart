import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

enum Section {
  nowPlaying,
  popular,
  upcoming,
}

abstract class MovieListEvent {}

class LoadMoviesEvent extends MovieListEvent {
  final Section section;

  LoadMoviesEvent(this.section);
}

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository repository;

  MovieListBloc({
    required this.repository,
    Section? section,
  }) : super(MovieListState()) {
    on<LoadMoviesEvent>((event, emit) async {
      late final MovieList movieList;

      switch (event.section) {
        case Section.nowPlaying:
          movieList = await repository.getNotPlaying();
          break;
        case Section.upcoming:
          movieList = await repository.getUpcoming();
          break;
        case Section.popular:
          movieList = await repository.getPopular();
          break;
      }
      emit(MovieListState(movies: movieList.results));
    });

    if (section == null) {
      return;
    }

    add(LoadMoviesEvent(section));
  }
}

class MovieListState {
  final List<Movie> movies;

  int get length => movies.length;

  MovieListState({
    this.movies = const [],
  });
}
