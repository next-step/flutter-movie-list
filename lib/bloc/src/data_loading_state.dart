abstract class DataLoadingState {}

class InitState extends DataLoadingState {}

class LoadingState extends DataLoadingState {}

class LoadedState<T> extends DataLoadingState {
  LoadedState({required this.data});

  final T data;
}

class EmptyState extends DataLoadingState {}

class LoadErrorState extends DataLoadingState {}