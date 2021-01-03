part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

// custom
abstract class SaveCounterDelegate {
  void onSuccess(String message);
  void onError(String message);
}

class IncrementCounter extends CounterEvent {
  final int count;

  IncrementCounter(this.count);

  @override
  String toString() => "IncrementCounter{count: $count";
}

class ResetCounter extends CounterEvent {
  @override
  String toString() => "ResetCounter";
}


class SaveCounter extends CounterEvent {

  final SaveCounterDelegate saveCounterDelegate;

  SaveCounter(this.saveCounterDelegate);

  @override
  String toString() => "SaveCounter {SaveCounterDelegate: $saveCounterDelegate}";
}

class LoadCounter extends CounterEvent {
  @override
  String toString() => "LoadCounter";
}
