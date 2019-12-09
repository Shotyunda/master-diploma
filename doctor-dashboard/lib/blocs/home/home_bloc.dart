import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/repositories/doctor/repositories.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DoctorRepository _doctorRepository = DoctorRepository(doctorApiClient: DoctorApiClient(httpClient: http.Client()));

  AuthBloc authBloc;

  HomeBloc({this.authBloc});

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchPatientsForHome) {
      try {
        List<Patient> patients = await _doctorRepository.patients(id: authBloc.state.doctor_info.toString(), token: authBloc.state.token);
        yield PatientsFetchedHomeState(patients: patients);
      } catch(error) {
        yield HomeFailure(error: error.toString());
      }
    } else if (event is OpenDiaryPage) {
      yield PatientDiaryPageLoaded(patient: event.patient);
    }
  }
}
