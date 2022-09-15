import 'dart:async';

import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

import 'data_loading.dart';


abstract class MovieCubit extends Cubit<DataLoadingState> {
  MovieCubit() : super(LoadingState());

  void load();
}

class MainCubit extends Cubit<DataLoadingState> {
  MainCubit({required this.cubits}) : super(LoadingState()) {
    _subscriptions = cubits.map((e) => e.stream).map((s) {
      return s.listen((event) {
        if (event is LoadErrorState) {
          _errorCount++;
        }
        
        if (_errorCount >= 2) {
          emit(LoadErrorState());
        } else {
          emit(event);
        }
      });
    }).toList(growable: false);
  }

  List<MovieCubit> cubits = [];

  late List<StreamSubscription<DataLoadingState>> _subscriptions;
  var _errorCount = 0;

  void refresh() {
    _errorCount = 0;
    for (var element in cubits) {
      element.load();
    }
  }

  @override
  Future<void> close() {
    _subscriptions.clear();
    return super.close();
  }
}

class NowPlayingMovieCubit extends MovieCubit {
  NowPlayingMovieCubit({required this.repository});

  final MovieRepository repository;

  @override
  void load() async {
    try {
      final movieList = await repository.getNotPlaying();
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
      emit(LoadedState<MovieList>(data: movieList));
    } catch (e) {
      emit(LoadErrorState());
    }
  }
}

class UpcomingMovieCubit extends MovieCubit {
  UpcomingMovieCubit({required this.repository});

  final MovieRepository repository;

  @override
  void load() async {
    final movieList = await repository.getUpcoming();
    emit(LoadedState<MovieList>(data: movieList));
  }
}

class DetailMovieCubit extends Cubit<DataLoadingState> {
  DetailMovieCubit({required this.repository}) : super(LoadingState());

  final MovieRepository repository;

  void load({required int movieId}) async {
    final movie = await repository.getDetail(movieId: movieId);
    emit(LoadedState<DetailMovie>(data: movie));
  }
}