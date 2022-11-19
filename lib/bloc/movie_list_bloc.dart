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
  int _loadingErrCount = 0;

  MovieListBloc({
    required this.repository,
  }) : super(MovieListLoadingState()) {

    on<LoadMoviesEvent>((event, emit) async {
      late final MovieList movieList;

      emit(MovieListLoadingState());

      try {
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
        emit(MovieListLoadedState(movies: movieList.results, section: event.section));
      } on ApiLoadingError {
        emit(MovieListLoadedState.empty());
        _loadingErrCount++;

        if(_loadingErrCount > 1){
          emit(MovieListErrorState(errMsg: '정보를 가져오는데 실패하였습니다.'));
        }
      }
    });
  }
}

abstract class MovieListState {}

class MovieListLoadingState extends MovieListState {}

class MovieListLoadedState extends MovieListState {
  final Section? section;
  final List<Movie> movies;

  int get length => movies.length;

  static final _empty = MovieListLoadedState(movies: []);

  MovieListLoadedState({
    required this.movies,
    this.section,
  });

  factory MovieListLoadedState.empty() {
    return _empty;
  }
}

class MovieListErrorState extends MovieListState {
  final String errMsg;

  MovieListErrorState({
    this.errMsg = '',
  });
}
