import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DoctorInfoEvent extends Equatable {
  const DoctorInfoEvent();

  @override
  List<Object> get props => null;
}

class ToInitialDoctorInfo extends DoctorInfoEvent {}

class FirstStepDone extends DoctorInfoEvent {}

class SecondStepDone extends DoctorInfoEvent {}

class ThirdStepDone extends DoctorInfoEvent {}

class FourStepDone extends DoctorInfoEvent {}

class SaveDoctorInfo extends DoctorInfoEvent {
  final dynamic record;

  SaveDoctorInfo({@required this.record});
}
