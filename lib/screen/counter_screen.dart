import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_event.dart';
import '../bloc/counter/counter_state.dart';

/// Main app screen with counter.
class CounterScreen extends StatelessWidget {
  final String title;
  final int index;

  /// Main app screen with counter.
  const CounterScreen({@required this.title, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Reset Counter"),
                content: Text(
                    // ignore: lines_longer_than_80_chars
                    "This will reset the counter to zero.\nAre you sure?"),
                actions: [
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    child: Text("Reset Counter"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ).then((value) {
              if (value == true) {
                BlocProvider.of<CounterBloc>(context)
                    .add(SetCounterEvent(index, 0));
              }
            }),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Image(
                  width: 600,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/tring_together_logo.png'),
                ),
              ),
            ),
            */
            Padding(padding: EdgeInsets.symmetric(vertical: 12)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 48,
                    icon: Icon(Icons.arrow_upward),
                    onPressed: () => BlocProvider.of<CounterBloc>(context)
                        .add(ModifyCounterEvent(index, 1)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: BlocBuilder<CounterBloc, CounterState>(
                      builder: (context, state) {
                        if (state is LoadingCounterState) {
                          return CircularProgressIndicator();
                        }
                        if (state is LiveCounterState) {
                          return Text(
                            state.value[index].toString(),
                            style: TextStyle(fontSize: 36),
                          );
                        }
                        throw FallThroughError();
                      },
                    ),
                  ),
                  IconButton(
                    iconSize: 48,
                    icon: Icon(Icons.arrow_downward),
                    onPressed: () => BlocProvider.of<CounterBloc>(context)
                        .add(ModifyCounterEvent(index, -1)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
