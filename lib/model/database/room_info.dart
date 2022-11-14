import 'package:equatable/equatable.dart';

class RoomInfo extends Equatable {
  final String title;
  final List<String> locations;

  const RoomInfo({required this.title, required this.locations});

  @override
  List<Object?> get props => [title, locations];
}
