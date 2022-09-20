import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/src/movie_detail.dart';
import 'package:flutter_movie_list/repository/repository.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({required MovieRepository repository})
      : _repository = repository,
        super(Loading()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
  }

  final MovieRepository _repository;

  void _onFetchMovieDetail(FetchMovieDetail event, Emitter<DetailState> emit) async {
    try {
      final detail = await _repository.getDetail(event.id);
      emit(Loaded(detail: detail));
    } catch (e) {
      emit(Error());
    }
  }
}
