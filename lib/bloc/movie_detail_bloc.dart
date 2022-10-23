import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/bloc/src/api_state.dart';
import 'package:flutter_movie_list/model/src/movie_detail.dart';
import 'package:flutter_movie_list/repository/src/movie_detail_repository.dart';

abstract class ApiStateCubit extends Cubit<ApiState> {
  ApiStateCubit() : super(LoadingState());

  void loadWithParam(param);
}

class MovieDetailCubit extends ApiStateCubit {
  MovieDetailCubit({required this.repository});

  final MovieDetailRepository repository;

  @override
  void loadWithParam(movieId) async {
    try {
      final movieData = await repository.getMovieDetail(movieId);
      emit(LoadedState<MovieDetail>(data: movieData));
    } catch (e) {
      emit(LoadErrorState());
    }
  }
}