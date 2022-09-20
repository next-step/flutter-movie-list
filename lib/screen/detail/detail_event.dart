part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent{}

class FetchMovieDetail extends DetailEvent {
  FetchMovieDetail({required this.id});

  final int id;
}