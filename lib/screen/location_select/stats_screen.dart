import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config.dart';
import '../../extension/datetime_to_excel_date.dart';

import '../../bloc/stats/stats_bloc.dart';
import '../../bloc/stats/stats_event.dart';
import '../../bloc/stats/stats_state.dart';
import '../../model/entries_chart_point.dart';
import '../../model/entries_table_source.dart';
import '../../model/room_info.dart';

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

  List<DateTime> get _chartRange {
    final _now = DateTime.now();
    return [
      DateTime(_now.year, _now.month, _now.day, 11, 00),
      DateTime(_now.year, _now.month, _now.day, 11, 10),
      DateTime(_now.year, _now.month, _now.day, 11, 20),
      DateTime(_now.year, _now.month, _now.day, 11, 30),
      DateTime(_now.year, _now.month, _now.day, 11, 40),
      DateTime(_now.year, _now.month, _now.day, 11, 50),
      //
      DateTime(_now.year, _now.month, _now.day, 12, 00),
      DateTime(_now.year, _now.month, _now.day, 12, 10),
      DateTime(_now.year, _now.month, _now.day, 12, 20),
      DateTime(_now.year, _now.month, _now.day, 12, 30),
      DateTime(_now.year, _now.month, _now.day, 12, 40),
      DateTime(_now.year, _now.month, _now.day, 12, 50),
      //
      DateTime(_now.year, _now.month, _now.day, 13, 00),
      DateTime(_now.year, _now.month, _now.day, 13, 10),
      DateTime(_now.year, _now.month, _now.day, 13, 20),
      DateTime(_now.year, _now.month, _now.day, 13, 30),
      DateTime(_now.year, _now.month, _now.day, 13, 40),
      DateTime(_now.year, _now.month, _now.day, 13, 50),
      //
      DateTime(_now.year, _now.month, _now.day, 14, 00),
      DateTime(_now.year, _now.month, _now.day, 14, 10),
      DateTime(_now.year, _now.month, _now.day, 14, 20),
      DateTime(_now.year, _now.month, _now.day, 14, 30),
      DateTime(_now.year, _now.month, _now.day, 14, 40),
      DateTime(_now.year, _now.month, _now.day, 14, 50),
      //
      DateTime(_now.year, _now.month, _now.day, 15, 00),
      DateTime(_now.year, _now.month, _now.day, 15, 10),
      DateTime(_now.year, _now.month, _now.day, 15, 20),
      DateTime(_now.year, _now.month, _now.day, 15, 30),
      DateTime(_now.year, _now.month, _now.day, 15, 40),
      DateTime(_now.year, _now.month, _now.day, 15, 50),
      //
      DateTime(_now.year, _now.month, _now.day, 16, 00),
    ];
  }

  bool get _isWithinRange {
    final _now = DateTime.now();
    return (_now.hour >= 11 && _now.hour < 16);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(builder: (context, statsState) {
      if (statsState is StatsNotLoaded) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No stats report loaded',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "Requesting a stats report is expensive:\nPlease only do so if you know what you're doing!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => BlocProvider.of<StatsBloc>(context)
                      .add(const LoadStatsEvent()),
                  child: const Text('Request Report'),
                ),
              ],
            ),
          ),
        );
      }

      if (statsState is! StatsLoaded) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      final _snapshot = (statsState).snapshot;

      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => BlocProvider.of<StatsBloc>(context)
                    .add(const LoadStatsEvent()),
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: SingleChildScrollView(
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
              Text(
                'Generated at: ' + statsState.generatedAt.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 16),
              // Summary stats
              Text(
                'Summary Statistics',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 24),
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
                              DataCell(Text(_snapshot.totalEntries.toString())),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),

              // Entries chart
              Text(
                'Hourly Figures',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: SizedBox(
                  height: 400,
                  child: Text('No charts library'),
                ),
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),

              // Entries table
              Text(
                'Entries Table',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 24),
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
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    const csvHeaders = [
                      'location',
                      'millisecondsSinceEpoch',
                      'excelTime',
                      'type',
                    ];

                    final logs = statsState.snapshot.logs
                        .map(
                          (log) => [
                            widget.roomInfo.locations[log.location],
                            log.time.millisecondsSinceEpoch.toString(),
                            log.time.toExcelDate().toString(),
                            log.type.toString(),
                          ],
                        )
                        .toList();

                    final csvData = const ListToCsvConverter()
                        .convert([csvHeaders, ...logs]);

                    await FileSaver.instance.saveFile(
                      roomCode + '_raw',
                      Uint8List.fromList(csvData.codeUnits),
                      'csv',
                      mimeType: MimeType.CSV,
                    );
                  },
                  child: const Text('Export Raw Data'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
    });
  }
}
