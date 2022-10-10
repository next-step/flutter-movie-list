import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/bloc/src/api_state.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

abstract class MovieCubit extends Cubit<ApiState> {
  MovieCubit() : super(LoadingState());

  void load();
}

class UpcomingMovieCubit extends MovieCubit {
  UpcomingMovieCubit({required this.repository});

  final MovieRepository repository;

  @override
  void load() async {
    try {
      final movieList = await repository.getUpcoming();
      emit(LoadedState<MovieList>(data: movieList));
    } catch (e) {
      emit(LoadErrorState());
    }
  }
}

class PopularMovieCubit extends MovieCubit {
  PopularMovieCubit({required this.repository});

  final MovieRepository repository;

  @override
  void load() async {
    try {
      final movieList = await repository.getPopular();
      throw Error();
      // emit(LoadedState<MovieList>(data: movieList));
    } catch (e) {
      emit(LoadErrorState());
    }
  }
}

class NowPlayingMovieCubit extends MovieCubit {
  NowPlayingMovieCubit({required this.repository});

  final MovieRepository repository;

  @override
  void load() async {
    try {
      final movieList = await repository.getNowPlaying();
      throw Error();
      // emit(LoadedState<MovieList>(data: movieList));
    } catch (e) {
      emit(LoadErrorState());
    }
  }
}
