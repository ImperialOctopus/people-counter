import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              /*
              // Entries chart
              
              Text(
                'Hourly Entries',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              TimeSeriesChart(
                [
                  Series<EntriesChartPoint, DateTime>(
                    id: 'Entries',
                    colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
                    domainFn: (EntriesChartPoint entries, _) => entries.time,
                    measureFn: (EntriesChartPoint entries, _) =>
                        entries.frequency,
                    data: [
                      EntriesChartPoint(
                          time: DateTime(2017, 9, 19), frequency: 5),
                      EntriesChartPoint(
                          time: DateTime(2017, 9, 26), frequency: 25),
                      EntriesChartPoint(
                          time: DateTime(2017, 10, 3), frequency: 100),
                      EntriesChartPoint(
                          time: DateTime(2017, 10, 10), frequency: 75),
                    ],
                  ),
                ],
                animate: true,
                // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                // should create the same type of [DateTime] as the data provided. If none
                // specified, the default creates local date time.
                dateTimeFactory: const LocalDateTimeFactory(),
              ),
              
              const Divider(),
              const SizedBox(height: 48),
              */
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
