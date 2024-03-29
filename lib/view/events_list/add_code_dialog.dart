import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/repositories/events/events_repository.dart';

enum AddCodeDialogPage { enter, test }

class AddCodeDialog extends StatefulWidget {
  const AddCodeDialog({super.key});

  @override
  State<AddCodeDialog> createState() => _AddCodeDialogState();
}

class _AddCodeDialogState extends State<AddCodeDialog> {
  AddCodeDialogPage page = AddCodeDialogPage.enter;
  Future<EventConnection?>? eventConnection;

  bool submitEnabled = false;

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      switch (page) {
        case AddCodeDialogPage.enter:
          return _enterPage(context);
        case AddCodeDialogPage.test:
          return _testPage(context);
      }
    });
  }

  Widget _enterPage(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 10.0,
      ),
      title: Text(
        "Add Event",
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        //height: 400,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _textFieldController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter event code here.',
                          labelText: 'Event code'),
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (String? text) {
                        if (text?.isNotEmpty ?? false) {
                          setState(() {
                            submitEnabled = true;
                          });
                        } else {
                          setState(() {
                            submitEnabled = false;
                          });
                        }
                      }),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: submitEnabled
                        ? () => setState(() {
                              page = AddCodeDialogPage.test;
                              eventConnection = context
                                  .read<EventsRepository>()
                                  .getEventByCode(_textFieldController.text);
                            })
                        : null,
                    child: const Text("Submit"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop<String?>(null),
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _testPage(BuildContext context) {
    return FutureBuilder<EventConnection?>(
        future: eventConnection,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _waitingPage(context);
          } else if (snapshot.hasData) {
            return _successPage(context, snapshot.data!);
          } else {
            return _failPage(context);
          }
        });
  }

  Widget _waitingPage(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 10.0,
      ),
      title: Text(
        "Finding event...",
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        //height: 400,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop<String?>(null),
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _successPage(BuildContext context, EventConnection eventConnection) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 10.0,
      ),
      title: Text(
        'Event found: ${eventConnection.name}',
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        //height: 400,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Icon(Icons.check,
                        size: 64, color: Colors.green.shade300),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pop<String?>(_textFieldController.value.text),
                    child: const Text("Save"),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _failPage(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 10.0,
      ),
      title: Text(
        "'${_textFieldController.value.text}' not found.",
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        //height: 400,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child:
                        Icon(Icons.close, size: 64, color: Colors.red.shade300),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop<String?>(null),
                    child: const Text("Close"),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
