import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:doctor/blocs/auth/auth_bloc.dart';
import 'package:doctor/blocs/auth/blocs.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/repositories/doctor/doctor_api_client.dart';
import 'package:doctor/repositories/doctor/doctor_repository.dart';
import 'package:doctor/repositories/university/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import './bloc.dart';

class DoctorInfoBloc extends Bloc<DoctorInfoEvent, DoctorInfoState> {
  final AuthBloc authBloc;

  final UniversityRepository _universityRepository = UniversityRepository(universityApiClient: UniversityApiClient(httpClient: http.Client()));
  final DoctorRepository _doctorRepository = DoctorRepository(doctorApiClient: DoctorApiClient(httpClient: http.Client()));

  DoctorInfoBloc({@required this.authBloc});

  @override
  DoctorInfoState get initialState => InitialDoctorInfoState();

  @override
  Stream<DoctorInfoState> mapEventToState(
    DoctorInfoEvent event,
  ) async* {
    print(event);
    if (event is ToInitialDoctorInfo) {
      yield FirstStepDoctorInfoState();
    }

    if (event is FirstStepDone) {
      List<University> universities = await _universityRepository.list(token: authBloc.state.token);
      yield FirstStepDoneInfoState(universities: universities);
    }

    if (event is SecondStepDone) {
      yield SecondStepDoneInfoState();
    }

    if (event is ThirdStepDone) {
      yield ThreeStepDoneInfoState();
    }

    if (event is FourStepDone) {
      yield FourStepDoneInfoState();
    }

    if (event is SaveDoctorInfo) {
      yield DoctorLoading();
      try {
        await this._doctorRepository.update(record: event.record, id: authBloc.state.doctor_info.toString(), token: authBloc.state.token);
        authBloc.add(FillAccount());
        yield FourStepDoneInfoState();
      } catch(error) {
        print(error);
      }
    }
  }
}
