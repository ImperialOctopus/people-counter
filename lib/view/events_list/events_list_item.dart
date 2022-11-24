import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/blocs/code_list/code_list_event.dart';
import 'package:provider/provider.dart';

import '../../blocs/code_list/code_list_bloc.dart';
import '../../repositories/events/events_repository.dart';
import '../event/event_screen.dart';

class EventsListItem extends StatefulWidget {
  final String code;

  const EventsListItem({super.key, required this.code});

  @override
  State<EventsListItem> createState() => _EventsListItemState();
}

class _EventsListItemState extends State<EventsListItem> {
  late final Future<EventConnection> eventConnection;
  late final Future<String> name;
  late final String code;

  @override
  void initState() {
    code = widget.code;
    eventConnection = context.read<EventsRepository>().getEventByCode(code);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: eventConnection,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListTile(
            title: Text(snapshot.data!.name),
            onTap: () => _onTap(snapshot.data!),
            onLongPress: _onLongPress,
          );
        } else if (snapshot.hasError) {
          return ListTile(
            leading: Icon(Icons.error_outline, color: Colors.red.shade400),
            title: Text('$code failed to load.'),
            onLongPress: _onLongPress,
          );
        } else {
          return ListTile(
            leading: const CircularProgressIndicator(),
            onLongPress: _onLongPress,
          );
        }
      },
    );
  }

  void _onTap(EventConnection eventConnection) {
    Navigator.of(context)
        .push(EventScreen.route(eventConnection: eventConnection));
  }

  void _onLongPress() {
    context.read<CodeListBloc>().add(RemoveCodeEvent(code));
  }
}
