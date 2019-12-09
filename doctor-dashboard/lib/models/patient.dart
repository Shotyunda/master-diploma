import 'package:doctor/models/diabetes_type.dart';
import 'package:doctor/models/models.dart';
import 'package:equatable/equatable.dart';

import 'diary.dart';

class Patient extends Equatable {
  final int id;
  final String first_name;
  final String last_name;
  final String sex;
  final double weight;
  final double growth;
  final String birthday;
  final List<Diary> diary;
  final DiabetesType type;
  final Therapy therapy;

  const Patient({
    this.id,
    this.first_name = '',
    this.last_name = '',
    this.sex = '',
    this.weight = 0,
    this.growth = 0,
    this.birthday = '',
    this.diary = const [],
    this.type,
    this.therapy,
  });

  @override
  List<Object> get props => [
    id,
    first_name,
    last_name,
    sex,
    weight,
    growth,
    birthday,
  ];

  static Patient fromJson(dynamic json) {
    return Patient(
      id: json['id'] as int,
      first_name: json['first_name'],
      last_name: json['last_name'],
      sex: json['sex'],
      weight: double.parse(json['weight'].toString()),
      growth: double.parse(json['growth'].toString()),
      birthday: json['birthday'],
      diary: json['diary'] != null ? json['diary'].map<Diary>((record) {
        return Diary.fromJson(record);
      }).toList() : null,
      therapy: json['therapy_id'] != null ? Therapy.fromJson(json['therapy_id']) : null,
      type: json['diabetes_type'] != null ? DiabetesType.fromJson(json['diabetes_type']) : null,
    );
  }
}
