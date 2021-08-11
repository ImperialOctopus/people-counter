import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/model/entries_table_source.dart';
import 'package:people_counter/model/room_info.dart';

import '../../bloc/stats/stats_bloc.dart';
import '../../bloc/stats/stats_state.dart';

class StatsScreen extends StatefulWidget {
  static const double _tablePadding = 48;

  final RoomInfo roomInfo;

  const StatsScreen({required this.roomInfo, Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late final DataTableSource _entriesTableSource;

  @override
  void initState() {
    _entriesTableSource = EntriesTableSource(
        statsBloc: BlocProvider.of<StatsBloc>(context),
        roomInfo: widget.roomInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<StatsBloc, StatsState>(builder: (context, statsState) {
        if (statsState is! StatsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                widget.roomInfo.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 16),
              // Summary stats
              Text(
                'Summary Statistics',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: StatsScreen._tablePadding),
                child: Center(
                  child: SizedBox(
                    width: 500,
                    child: Card(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Stat')),
                          DataColumn(label: Text('Value')),
                        ],
                        rows: [
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Total Entries')),
                              DataCell(Text(
                                  statsState.snapshot.totalEntries.toString())),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 48),
              // Entries table
              Text(
                'Entries Table',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: StatsScreen._tablePadding),
                child: Center(
                  child: SizedBox(
                    width: 500,
                    child: PaginatedDataTable(
                      source: _entriesTableSource,
                      columns: const [
                        DataColumn(label: Text('Time')),
                        DataColumn(label: Text('Location')),
                        DataColumn(label: Text('Type')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
