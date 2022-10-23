abstract class ApiState {}

class LoadingState extends ApiState {}

class LoadedState<T> extends ApiState {
  LoadedState({required this.data});

  final T data;
}

class LoadErrorState extends ApiState {}