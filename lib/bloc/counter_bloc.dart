import 'dart:async';

import 'package:bloc/bloc.dart';
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
      yield* _mapIncrementCounterToState(event);
    } else if (event is ResetCounter) {
      // yield 0;
      yield* _mapResetCounterToState();
    } else if (event is SaveCounter) {
      yield* _mapSaveCounterToState(event);
      // return yield ซ้อน yield ใช้ *
    } else if (event is LoadCounter) {
      yield* _mapLoadCounterToState();
    }
  }

  Stream<CounterState> _mapSaveCounterToState(SaveCounter event) async* {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt(PREF_COUNT, state);
    // yield state;
    try {
      var countOfState = (state as LoadedCounterState).count;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(PREF_COUNT, countOfState);
      
      yield SaveCounterState(countOfState);

      // yield state;
      event.saveCounterDelegate.onSuccess('สำเร็จ: $countOfState' );
    } catch (e) {
      event.saveCounterDelegate.onError(e.toString());
      // yield ErrorCounterState(e.toString());
    }
  }

  Stream<CounterState> _mapIncrementCounterToState(
      IncrementCounter event) async* {
    try {
      var countOfEvent = event.count; // สิ่งที่ส่งเข้ามา
      var countOfState = (state as LoadedCounterState).count; // สิ่งที่มีอยู่

      yield LoadedCounterState(countOfEvent + countOfState);
    } catch (e) {
      yield ErrorCounterState(e.toString());
    }
  }

  Stream<CounterState> _mapResetCounterToState() async* {
    try {
      yield LoadedCounterState(0);
    } catch (e) {
      yield ErrorCounterState(e.toString());
    }
  }
}

Stream<CounterState> _mapLoadCounterToState() async* {
  try {
    yield LoadingCounterState();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(PREF_COUNT) ?? 0;
    await Future.delayed(Duration(seconds: 2));
    yield LoadedCounterState(count);
  } catch (e) {
    yield ErrorCounterState(e.toString());
  }
}
