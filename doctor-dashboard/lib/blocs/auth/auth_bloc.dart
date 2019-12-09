import 'package:doctor/models/models.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/blocs/auth/blocs.dart';


import 'package:doctor/models/user.dart';
import 'package:doctor/repositories/repositories.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final DoctorRepository _doctorRepository = DoctorRepository(doctorApiClient: DoctorApiClient(httpClient: http.Client()));
  User user;

  AuthBloc({@required this.authRepository})
    : assert(authRepository != null);

  @override
  AuthState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
//      final bool hasToken = await authRepository.hasToken();
//      user = await authRepository.getUser();
//      Doctor doctor;

//      if (hasToken) {
//        doctor = await _doctorRepository.doctor(token: user.token, id: user.doctor_info.toString());
//      }

      yield AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      Doctor doctor;
      yield AuthenticationLoading();
      user = event.user;
//      await authRepository.persistInfo(event.user);
      doctor = await _doctorRepository.doctor(token: user.token, id: user.doctor_info.toString());
      yield AuthenticationAuthenticated(user: event.user, doctor: doctor);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
//      await authRepository.delete();
      yield AuthenticationUnauthenticated();
    }

    if (event is FillAccount) {
      await authRepository.fill('true');
    }
  }
}
