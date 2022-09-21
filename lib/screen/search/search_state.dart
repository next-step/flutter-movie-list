part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class Empty extends SearchState {}

class Loading extends SearchState {}

class Loaded extends SearchState {
  Loaded({
    required this.searched,
  });

  final MovieList searched;
}

class Error extends SearchState {}