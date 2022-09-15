abstract class DataLoadingState {}

class LoadingState extends DataLoadingState {}

class LoadedState<T> extends DataLoadingState {
  LoadedState({required this.data});

  final T data;
}

class LoadErrorState extends DataLoadingState {}