import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:meta/meta.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({required MovieRepository repository})
      : _repository = repository,
        super(DetailInitial()) {
    on<DetailEvent>((event, emit) {});
  }

  final MovieRepository _repository;
}
