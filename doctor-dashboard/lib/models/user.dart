import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String token;
  final bool filled;
  final int doctor_info;

  const User({
    this.id,
    this.token,
    this.filled = false,
    this.doctor_info,
  });

  @override
  List<Object> get props => [
    id,
    token,
    filled,
    doctor_info,
  ];

  static User fromJson(dynamic json) {
    final user = jsonDecode(json);
    return User(
      id: user.id as int,
      token: user.token,
      filled: user.filled as bool,
      doctor_info: user.doctor_info as int,
    );
  }
}
