import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/model/entries_chart_point.dart';
import 'package:people_counter/model/stats_snapshot.dart';

import '../../bloc/stats/stats_bloc.dart';
import '../../bloc/stats/stats_state.dart';
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
      DateTime(_now.year, _now.month, _now.day, 11),
      DateTime(_now.year, _now.month, _now.day, 11, 30),
      DateTime(_now.year, _now.month, _now.day, 12),
      DateTime(_now.year, _now.month, _now.day, 12, 30),
      DateTime(_now.year, _now.month, _now.day, 13),
      DateTime(_now.year, _now.month, _now.day, 13, 30),
      DateTime(_now.year, _now.month, _now.day, 14),
      DateTime(_now.year, _now.month, _now.day, 14, 30),
      DateTime(_now.year, _now.month, _now.day, 15),
      DateTime(_now.year, _now.month, _now.day, 15, 30),
      DateTime(_now.year, _now.month, _now.day, 16),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<StatsBloc, StatsState>(builder: (context, statsState) {
        if (statsState is! StatsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        final _snapshot = statsState.snapshot;

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: SizedBox(
                  height: 400,
                  child: TimeSeriesChart(
                    [
                      Series<EntriesChartPoint, DateTime>(
                        id: 'Entries',
                        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
                        domainFn: (EntriesChartPoint entries, _) =>
                            entries.time,
                        measureFn: (EntriesChartPoint entries, _) =>
                            entries.frequency,
                        data: _chartRange
                            .map(
                              (time) => EntriesChartPoint(
                                  time: time,
                                  frequency: (time.isBefore(DateTime.now()))
                                      ? _snapshot.totalBefore(time)
                                      : null),
                            )
                            .toList(),
                      ),
                    ],
                    animate: true,
                    // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                    // should create the same type of [DateTime] as the data provided. If none
                    // specified, the default creates local date time.
                    dateTimeFactory: const LocalDateTimeFactory(),
                  ),
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
            ],
          ),
        );
      }),
    );
  }
}