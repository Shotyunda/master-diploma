import 'package:doctor/models/models.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

class Doctor extends Equatable {
  final String id;
  final String first_name;
  final String last_name;
  final String sex;
  final String birthday;
  final String experience;
  final String current_work;
  final String course;
  final String about;
  final String university;
  final List<Patient> patients;

  Doctor({
    this.id = '',
    this.first_name,
    this.last_name,
    this.sex,
    this.birthday,
    this.experience,
    this.current_work,
    this.course,
    this.about,
    this.university,
    this.patients,
  });

  @override
  List<Object> get props => null;

  static Doctor fromJson(dynamic json) {
    return Doctor(
      first_name: json['first_name'],
      last_name: json['last_name'],
      sex: json['sex'],
      birthday: json['birthday'],
      experience: json['experience'].toString(),
      current_work: json['current_work'],
      course: json['course'],
      about: json['about'],
      university: json['university'].toString(),
      patients: json['patients'] != null ? json['patients'].map<Patient>((patient) {
        return Patient(
          id: patient['id'] as int,
          first_name: patient['first_name'],
          last_name: patient['last_name'],
          sex: patient['sex'],
          weight: double.parse(patient['weight'].toString()),
          growth: double.parse(patient['growth'].toString()),
          birthday: patient['birthday'],
        );
      }).toList() : [],
    );
  }
}
