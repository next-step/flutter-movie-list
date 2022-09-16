import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void _onFetchMovies(FetchMovies event, Emitter<HomeState> emit) async {
    final nowPlaying = _repository.getNotPlaying();
    final popular = _repository.getPopular();
    final upcoming = _repository.getUpcoming();

    emit(Loaded(
      nowPlaying: await nowPlaying,
      popular: await popular,
      upcoming: await upcoming,
    ));
  }

  final MovieRepository _repository;
}
