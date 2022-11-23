import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../model/src/search_results.dart';

class MovieSearchEvent {
  final String query;

  MovieSearchEvent(this.query);
}

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final MovieRepository repository;

  MovieSearchBloc({
    required this.repository,
  }) : super(MovieSearchLoadedState(null)) {
    on<MovieSearchEvent>(
      (event, emit) async {
        emit(MovieSearchLoadingState());
        late final SearchResults movieDetail;

        try {
          movieDetail = await repository.search(event.query);
          emit(MovieSearchLoadedState(movieDetail));
        } on Error {
          emit(MovieSearchErrorState());
        }
      },
      transformer: (events, mapper) => events.debounceTime(
        const Duration(milliseconds: 1500),
      ).switchMap(mapper),
    );
  }
}

abstract class MovieSearchState {}

class MovieSearchLoadingState extends MovieSearchState {}

class MovieSearchErrorState extends MovieSearchState {}

class MovieSearchLoadedState extends MovieSearchState {
  final SearchResults? results;

  MovieSearchLoadedState(this.results);
}
