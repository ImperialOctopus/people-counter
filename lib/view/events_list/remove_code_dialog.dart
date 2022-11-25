import 'package:flutter/material.dart';

class RemoveCodeDialog extends StatelessWidget {
  final String code;

  const RemoveCodeDialog({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
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
        "Remove event '$code?'",
        style: const TextStyle(fontSize: 24.0),
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
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop<bool?>(true),
                  child: const Text("Remove Event"),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop<bool?>(null),
                  child: const Text("Cancel"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
