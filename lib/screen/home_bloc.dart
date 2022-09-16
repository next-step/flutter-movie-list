import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/exception/fetch_movies_fail_exception.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required MovieRepository repository})
      : _repository = repository,
        super(Loading()) {
    on<FetchMovies>(_onFetchMovies);
  }

  final MovieRepository _repository;
  int _errorCount = 0;

  void _onFetchMovies(FetchMovies event, Emitter<HomeState> emit) async {
    try {
      final nowPlaying = _repository.getNotPlaying().onError(_onErrorHandle);
      final popular = _repository.getPopular().onError(_onErrorHandle);
      final upcoming = _repository.getUpcoming().onError(_onErrorHandle);

      emit(Loaded(
        nowPlaying: await nowPlaying,
        popular: await popular,
        upcoming: await upcoming,
      ));
    } catch(e) {
      emit(Error());
    }
  }

  MovieList _onErrorHandle(Object? error, StackTrace stackTrace) {
    _errorCount++;
    if (_errorCount >= 2) {
      throw FetchMoviesFailException();
    }

    return MovieList();
  }
}
