import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/room/room_bloc.dart';
import '../../bloc/room/room_event.dart';
import '../../bloc/room/room_state.dart';
import '../../extension/lowercase_text_formatter.dart';

class RoomSelectScreen extends StatefulWidget {
  final String title;

  const RoomSelectScreen({required this.title, Key? key}) : super(key: key);

  @override
  _RoomSelectScreenState createState() => _RoomSelectScreenState();
}

class _RoomSelectScreenState extends State<RoomSelectScreen> {
  final roomCodeController = TextEditingController();
  bool _submitEnabled = false;

  @override
  void dispose() {
    roomCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: roomCodeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LowercaseTextFormatter(),
                      ],
                      maxLines: null,
                      style: Theme.of(context).textTheme.headline4,
                      onChanged: (string) =>
                          setState(() => _submitEnabled = (string != '')),
                    ),
                  ),
                ),
                if (state is RoomStateError)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'failed to join event',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: (state is RoomStateLoading || state is RoomStateIn)
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            ElevatedButton(
                              child: const Text('Join Event'),
                              onPressed: _submitEnabled
                                  ? () {
                                      BlocProvider.of<RoomBloc>(context).add(
                                          EnterRoomEvent(
                                              roomCodeController.text));
                                    }
                                  : null,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            OutlinedButton(
                              child: const Text('Register New Event'),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Register New Event"),
                                  content: const Text(
                                      // ignore: lines_longer_than_80_chars
                                      "To register new events contact imperialoctopus@gmail.com with details of your event."),
                                  actions: [
                                    TextButton(
                                      child: const Text("Close"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
