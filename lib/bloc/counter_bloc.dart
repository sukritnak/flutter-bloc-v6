import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/semantics.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'counter_event.dart';
part 'counter_state.dart';

const PREF_COUNT = '';

// class CounterBloc extends Bloc<CounterEvent, int> {
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  // CounterBloc() : super(CounterInitial());
  CounterBloc() : super(CounterInitial());

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is IncrementCounter) {
      // print('${event.count}');
      // var temCount = state + event.count;
      // yield temCount;
      _mapIncrementCounterToState() {
        
      }
    } else if (event is ResetCounter) {
      yield 0;
    } else if (event is SaveCounter) {
      yield* mapSaveCounterToState();
      // return yield ซ้อน yield ใช้ *
    }
  }

  Stream<CounterState> mapSaveCounterToState() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PREF_COUNT, state);
    yield state;
  }
}
