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
