import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required MovieRepository repository})
      : _repository = repository,
        super(Empty()) {
    on<SearchMovies>(_onSearchMovies);
    on<ChangeSearchKeyword>(_onChangeSearchKeyword);
  }

  final MovieRepository _repository;

  void _onSearchMovies(SearchMovies event, Emitter<SearchState> emit) async {
    try {
      emit(Loading());
      final detail = await _repository.search(event.query);
      emit(Loaded(searched: detail));
    } catch(e) {
      emit(Error());
    }
  }

  void _onChangeSearchKeyword(ChangeSearchKeyword event, Emitter<SearchState> emit) async {
    try {
      emit(Loading());
      final detail = await _repository.search(event.query);
      emit(Loaded(searched: detail));
    } catch(e) {
      emit(Error());
    }
  }
}
