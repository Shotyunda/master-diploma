import 'package:doctor/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DoctorInfoState extends Equatable {
  const DoctorInfoState();
  final step = 0;
  final progress = 0.2;

  @override
  List<Object> get props => null;
}

class InitialDoctorInfoState extends DoctorInfoState {}

class FirstStepDoctorInfoState extends DoctorInfoState {
  final step = 0;
  final progress = 0.2;

  @override
  List<Object> get props => [];
}

class FirstStepDoneInfoState extends DoctorInfoState {
  final step = 1;
  final progress = 0.4;
  final List<University> universities;

  FirstStepDoneInfoState({@required this.universities});

  @override
  List<Object> get props => [];
}

class SecondStepDoneInfoState extends DoctorInfoState {
  final step = 2;
  final progress = 0.6;

  @override
  List<Object> get props => [];
}

class ThreeStepDoneInfoState extends DoctorInfoState {
  final step = 3;
  final progress = 0.8;

  @override
  List<Object> get props => [];
}

class FourStepDoneInfoState extends DoctorInfoState {
  final step = 4;
  final progress = 1;

  @override
  List<Object> get props => [];
}

class DoctorLoading extends DoctorInfoState {}
