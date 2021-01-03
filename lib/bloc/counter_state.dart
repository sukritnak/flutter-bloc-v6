part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {
  @override
  String toString() => "init CounterInitial";
}

class LoadingCounterState extends CounterState {
  @override
  String toString() => "init LoadingCounterState";
}

class LoadedCounterState extends CounterState {
  final int count;

  LoadedCounterState(this.count);

  @override
  String toString() => "LoadedCounterState $count";
}

class SaveCounterState extends CounterState {
  final int count;

  SaveCounterState(this.count);

  @override
  String toString() => "SaveCounterState $count";
}

class ErrorCounterState extends CounterState {
  final String error;

  ErrorCounterState(this.error);

  @override
  String toString() => "ErrorCounterState $error";
}
