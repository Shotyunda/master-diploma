import 'package:doctor/models/models.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:doctor/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];

  User get currentUser => null;

  String get token => null;

  int get doctor_info => null;
}

class AuthenticationUninitialized extends AuthState {}

class AuthenticationAuthenticated extends AuthState {
  final User user;
  final Doctor doctor;

  const AuthenticationAuthenticated({@required this.user, @required this.doctor})
      : assert(user != null), assert(doctor != null);

  @override
  List<Object> get props => [user];

  @override
  User get currentUser => user;

  @override
  String get token => currentUser.token;

  @override
  int get doctor_info => currentUser.doctor_info;
}

class AuthenticationUnauthenticated extends AuthState {}

class AuthenticationLoading extends AuthState {}
