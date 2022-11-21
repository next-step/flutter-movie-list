import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

class MovieDetailEvent {
  final int id;

  MovieDetailEvent(this.id);
}

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository repository;

  MovieDetailBloc({
    required this.repository,
  }) : super(MovieDetailState(null)) {
    on<MovieDetailEvent>((event, emit) async {
      late final MovieDetail movieDetail;

      movieDetail = await repository.getMovieDetail(event.id);
      emit(MovieDetailState(movieDetail));
    });
  }
}

class MovieDetailState {
  final MovieDetail? detail;

  MovieDetailState(this.detail);
}
