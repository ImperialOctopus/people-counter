import 'package:flutter/material.dart';

class InvalidStateComponent extends StatelessWidget {
  const InvalidStateComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Invalid state. Please restart.'));
  }
}
