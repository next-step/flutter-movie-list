import 'package:flutter_movie_list/bloc/data_loading.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

abstract class SearchEvent {}

class InputCompleteEvent extends SearchEvent {
  InputCompleteEvent({this.query});

  final String? query;
}

class SearchBloc extends Bloc<SearchEvent, DataLoadingState> {
  SearchBloc({required this.repository}) : super(InitState()) {
    on<InputCompleteEvent>(_search);
  }

  final SearchRepository repository;

  Future<void> _search(InputCompleteEvent event, Emitter<DataLoadingState> emit) async {
    if (event.query == null) {
      emit(EmptyState());
      return;
    }

    emit(LoadingState());

    try {
      final movieList = await repository.search(query: event.query!);

      emit(movieList.results.isEmpty ? EmptyState() : LoadedState<MovieList>(data: movieList));
    } catch (e) {
      emit(LoadErrorState());
    }
  }
}