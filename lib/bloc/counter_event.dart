part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

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
  @override
  String toString() => "SaveCounter";
}
