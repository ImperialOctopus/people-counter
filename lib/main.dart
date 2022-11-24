import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'people_counter_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  //Bloc.observer = AppBlocObserver();

  runZonedGuarded(
    () => runApp(const PeopleCounterApp()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
