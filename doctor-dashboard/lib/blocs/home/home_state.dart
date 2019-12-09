import 'package:doctor/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => throw UnimplementedError();
}

class InitialHomeState extends HomeState {}

class PatientsFetchedHomeState extends HomeState {
  final List<Patient> patients;

  PatientsFetchedHomeState({@required this.patients});
}

class PatientDiaryPageLoaded extends HomeState {
  final Patient patient;

  PatientDiaryPageLoaded({this.patient});
}

class HomeFailure extends HomeState {
  final String error;

  const HomeFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
