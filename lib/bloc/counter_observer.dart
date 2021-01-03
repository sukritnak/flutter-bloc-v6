import 'package:bloc/bloc.dart';

class CounterObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('onTransition ${bloc.runtimeType}   with tran: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    print('onEvent ${bloc.runtimeType}   with event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('onError ${cubit.runtimeType}   with error: $error');
    print('stackTrace $stackTrace ');
    super.onError(cubit, onError, stackTrace);
  }
}
