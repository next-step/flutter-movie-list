part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  Loaded({
    required this.nowPlaying,
    required this.popular,
    required this.upcoming,
  });

  final MovieList nowPlaying;
  final MovieList popular;
  final MovieList upcoming;
}

class Error extends HomeState {}
