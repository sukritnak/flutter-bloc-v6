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

class MyHomePage extends StatelessWidget {
  CounterBloc _counterBloc;

  @override
  Widget build(BuildContext context) {
    _counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _counterBloc.add(SaveCounter());
              })
        ],
      ),
      body: BlocBuilder<CounterBloc, int>(
        builder: (BuildContext context, int state) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                state.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
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
}
