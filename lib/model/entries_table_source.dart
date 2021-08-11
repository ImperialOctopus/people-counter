import 'package:flutter/material.dart';
import 'package:people_counter/bloc/stats/stats_bloc.dart';
import 'package:people_counter/bloc/stats/stats_state.dart';
import 'package:people_counter/model/room_info.dart';
import 'package:people_counter/model/stats_snapshot.dart';

class EntriesTableSource extends DataTableSource {
  final StatsBloc statsBloc;
  final RoomInfo roomInfo;

  StatsSnapshot? snapshot;

  EntriesTableSource({required this.statsBloc, required this.roomInfo}) {
    updateData(statsBloc.state);
    statsBloc.stream.listen(updateData);
  }

  void updateData(StatsState state) {
    if (state is StatsHasStats) {
      snapshot = (state as StatsHasStats).snapshot;
    } else {
      snapshot = null;
    }
  }

  @override
  DataRow? getRow(int index) {
    final _data = snapshot?.logs[index];

    if (_data == null) {
      return null;
    } else {
      return DataRow(
        cells: [
          DataCell(
            Text(
              _data.time.day.toString() +
                  '/' +
                  _data.time.month.toString() +
                  '   ' +
                  _data.time.hour.toString() +
                  ':' +
                  _data.time.minute.toString(),
            ),
          ),
          DataCell(Text(roomInfo.locations[_data.location])),
          DataCell(Text(_data.type.toString())),
        ],
      );
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => snapshot?.logs.length ?? 0;

  @override
  int get selectedRowCount => 0;
}
