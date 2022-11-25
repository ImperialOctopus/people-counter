import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/blocs/code_list/code_list_event.dart';
import 'package:people_counter/view/components/list_card.dart';
import 'package:provider/provider.dart';

import '../../blocs/code_list/code_list_bloc.dart';
import '../../repositories/events/events_repository.dart';
import '../event/event_screen.dart';
import 'remove_code_dialog.dart';

class EventsListItem extends StatefulWidget {
  final String code;

  const EventsListItem({super.key, required this.code});

  @override
  State<EventsListItem> createState() => _EventsListItemState();
}

class _EventsListItemState extends State<EventsListItem> {
  late final Future<EventConnection?> eventConnection;
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListCard(
            leading: const SizedBox(
              height: 40,
              width: 40,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            title: Text('Loading $code'),
            onLongPress: _onLongPress,
          );
        } else if (snapshot.hasData) {
          return ListCard(
            leading: Icon(
              Icons.square,
              size: 40,
              color: _seededColour(snapshot.data!.code),
            ),
            title: Text(snapshot.data!.name),
            trailing: Text(snapshot.data!.code,
                style: const TextStyle(color: Colors.grey)),
            onTap: () => _onTap(snapshot.data!),
            onLongPress: _onLongPress,
          );
        } else {
          return ListCard(
            leading: Icon(
              Icons.error_outline,
              color: Colors.red.shade400,
              size: 40,
            ),
            title: Text('$code failed to load.'),
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
    showDialog<bool?>(
        context: context,
        builder: (context) => RemoveCodeDialog(code: code)).then((value) {
      if (value == null) {
        return;
      }
      context.read<CodeListBloc>().add(RemoveCodeEvent(code));
    });
  }

  Color _seededColour(String seed) {
    final bytes = utf8.encode(seed);
    final result = sha512.convert(bytes).bytes;
    return Color.fromARGB(
      255,
      result[0],
      result[1],
      result[2],
    );
  }
}
