import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:people_counter/config.dart';

import 'events_repository.dart';

class RailsEventsRepository implements EventsRepository {
  final String apiAddress;

  const RailsEventsRepository({required this.apiAddress});

  @override
  Future<EventConnection?> getEventByCode(String code) async {
    final uri = Uri.parse('$apiAddress/api/v1/events?code=$code');
    final response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok || response.body.isEmpty) {
      return null;
    }

    final json = jsonDecode(response.body);

    final name = json['name'];
    final eventId = json['id'];

    return RailsEventConnection._(
      apiAddress: apiAddress,
      eventId: eventId,
      code: code,
      name: name,
    );
  }
}

class RailsEventConnection implements EventConnection {
  final String apiAddress;
  final int eventId;

  @override
  final String code;
  @override
  final String name;

  Future<List<Future<LocationConnection>>>? _locations;

  RailsEventConnection._({
    required this.apiAddress,
    required this.eventId,
    required this.code,
    required this.name,
  });

  @override
  Future<List<Future<LocationConnection>>> get locations {
    return _locations ??= Future.microtask(() async {
      final uri = Uri.parse('$apiAddress/api/v1/events/$eventId/locations');
      final response = await http.get(uri);

      if (response.statusCode != HttpStatus.ok || response.body.isEmpty) {
        throw HttpException(response.statusCode.toString());
      }

      final json = jsonDecode(response.body) as List<dynamic>;

      return json.map((locationData) async {
        locationData as Map<String, dynamic>;

        final int locationId = locationData['id'];
        final String name = locationData['name'];
        final int startingCount = locationData['count'];

        return RailsLocationConnection._(
          name: name,
          current: startingCount,
          apiAddress: apiAddress,
          locationId: locationId,
        );
      }).toList();
    });
  }
}

class RailsLocationConnection implements LocationConnection {
  @override
  final String name;
  @override
  int current;

  @override
  Stream<int> get valuesStream => streamController.stream;

  final String apiAddress;
  final int locationId;

  final StreamController<int> streamController;
  Timer? _timer;

  RailsLocationConnection._({
    required this.name,
    required this.current,
    required this.apiAddress,
    required this.locationId,
  }) : streamController = StreamController<int>.broadcast() {
    streamController.add(current);

    _getValue();
  }

  void _getValue() async {
    final uri = Uri.parse('$apiAddress/api/v1/locations/$locationId');
    final response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok || response.body.isEmpty) {
      throw HttpException(response.statusCode.toString());
    }

    final json = jsonDecode(response.body);
    final value = json['count'] as int;

    _newValue(value);
  }

  void _newValue(int value) {
    if (value != current) {
      current = value;
      streamController.add(value);
    }

    _setTimer();
  }

  void _setTimer() async {
    _timer?.cancel();
    _timer = Timer(Config.httpReloadDelay, _getValue);
  }

  @override
  Future<void> sendIncrement() async {
    final uri = Uri.parse('$apiAddress/api/v1/locations/$locationId');
    final response = await http.post(uri, body: {'type': 'entry'});

    if (response.statusCode != HttpStatus.created || response.body.isEmpty) {
      throw HttpException(response.statusCode.toString());
    }

    final json = jsonDecode(response.body);
    final value = json['count'] as int;

    _newValue(value);
  }

  @override
  Future<void> sendDecrement() async {
    final uri = Uri.parse('$apiAddress/api/v1/locations/$locationId');
    final response = await http.post(uri, body: {'type': 'exit'});

    if (response.statusCode != HttpStatus.created || response.body.isEmpty) {
      throw HttpException(response.statusCode.toString());
    }

    final json = jsonDecode(response.body);
    final value = json['count'] as int;

    _newValue(value);
  }

  @override
  Future<void> sendReset() async {
    final uri = Uri.parse('$apiAddress/api/v1/locations/$locationId');
    final response = await http.post(uri, body: {'type': 'clear'});

    if (response.statusCode != HttpStatus.created || response.body.isEmpty) {
      throw HttpException(response.statusCode.toString());
    }

    final json = jsonDecode(response.body);
    final value = json['count'] as int;

    _newValue(value);
  }
}
