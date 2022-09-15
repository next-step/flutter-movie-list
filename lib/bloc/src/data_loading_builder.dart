import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_loading_state.dart';

class DataLoadingBuilder<B extends BlocBase<DataLoadingState>, DataLoadingState>
    extends BlocBuilderBase<B, DataLoadingState> {
  DataLoadingBuilder({
    Key? key,
    required this.builder,
    this.onLoad,
    this.onError,
    B? bloc,
    BlocBuilderCondition<DataLoadingState>? buildWhen,
  }) : super(key: key, bloc: bloc, buildWhen: buildWhen);

  final BlocWidgetBuilder builder;
  final WidgetBuilder? onLoad;
  final WidgetBuilder? onError;

  @override
  Widget build(BuildContext context, state) {
    switch (state.runtimeType) {
      case LoadingState:
        return onLoad == null ? SizedBox.shrink() : onLoad!(context);
      case LoadErrorState:
        return onError == null ? SizedBox.shrink() : onError!(context);
      default:
        return builder(context, state);
    }
  }
}