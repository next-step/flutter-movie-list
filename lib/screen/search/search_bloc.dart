import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required MovieRepository repository})
      : _repository = repository,
        super(Loading()) {
    on<SearchMovies>(_onSearchMovies);
  }

  final MovieRepository _repository;

  void _onSearchMovies(SearchMovies event, Emitter<SearchState> emit) async {
    try {
      final detail = await _repository.search(event.query);
      emit(Loaded(searched: detail));
    } catch(e) {
      emit(Error());
    }
  }
}
