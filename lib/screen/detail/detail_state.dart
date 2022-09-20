part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class Loading extends DetailState {}

class Loaded extends DetailState {
  Loaded({
    required this.detail,
  });

  final MovieDetail detail;
}

class Error extends DetailState {}
