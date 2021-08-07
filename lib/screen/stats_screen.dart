import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stats/stats_bloc.dart';
import '../bloc/stats/stats_event.dart';
import '../bloc/stats/stats_state.dart';

class StatsScreen extends StatelessWidget {
  final String title;

  const StatsScreen({required this.title});

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
                title: Text("Reset Stats"),
                content: Text(
                    // ignore: lines_longer_than_80_chars
                    "This will reset all stats for this event.\nAre you sure?"),
                actions: [
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: Text("Reset Stats"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ).then((value) {
              if (value == true) {
                BlocProvider.of<StatsBloc>(context)
                    .add(const ResetStatsEvent());
              }
            }),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
          if (state is StatsLoaded) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                      Column(
                        children: [
                          Text('Total Entries:'),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
