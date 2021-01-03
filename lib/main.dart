import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/bloc/counter_bloc.dart';

import 'bloc/counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter bloc v6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (BuildContext context) => CounterBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget implements SaveCounterDelegate {
  CounterBloc _counterBloc;

  var _context;

  @override
  void onError(String message) {
    // TODO: implement onError
    showAlertDialog(message);
  }

  @override
  void onSuccess(String message) {
    // TODO: implement onSuccess
    showAlertDialog(message);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _counterBloc.add(LoadCounter());
              }),
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _counterBloc.add(SaveCounter(this));
              })
        ],
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
          builder: (BuildContext context, CounterState state) {
        // if (state is LoadingCounterState) {
        // แค่จะดู log
        //   return Center(child: CircularProgressIndicator());
        // }

        if (state is LoadedCounterState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  state.count.toString(),
                  // state.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          );
        }

         if (state is SaveCounterState || state is CounterInitial) {
          _counterBloc.add(LoadCounter());
          return SizedBox();
        }

        // if (state is CounterInitial) {
        //   _counterBloc.add(LoadCounter());
        // }

        if (state is ErrorCounterState) {
          return Center(child: Text('${state.error}'));
        }

        return Center(child: CircularProgressIndicator());
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _counterBloc.add(IncrementCounter(1));
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              _counterBloc.add(ResetCounter());
            },
            child: Icon(Icons.restore),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void showAlertDialog(String message) {
    showDialog(
        context: _context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            content: Text(message),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text('close'))
            ],
          );
        });
  }
}
