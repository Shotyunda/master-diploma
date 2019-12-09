import 'package:doctor/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => throw UnimplementedError();
}

class FetchPatientsForHome extends HomeEvent {}

class OpenDiaryPage extends HomeEvent {
  final Patient patient;

  OpenDiaryPage({this.patient});
}
