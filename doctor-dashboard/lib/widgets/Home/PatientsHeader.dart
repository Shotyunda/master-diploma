import 'package:doctor/helpers/functions.dart';
import 'package:doctor/models/diary.dart';
import 'package:doctor/models/patient.dart';
import 'package:flutter/material.dart';

class PatientsHeader extends StatelessWidget {
  List<Patient> patients;

  PatientsHeader({this.patients = const []});

  @override
  Widget build(BuildContext context) {
    int badLength = patients.where((patient) => calculateA1c(calculateGlucoseAvg(patient.diary)) > 11 || calculateA1c(calculateGlucoseAvg(patient.diary)) < 4).length;
    int needControlLength = patients.where((patient) => calculateA1c(calculateGlucoseAvg(patient.diary)) >= 8 && calculateA1c(calculateGlucoseAvg(patient.diary)) < 11 || calculateA1c(calculateGlucoseAvg(patient.diary)) >= 4 && calculateA1c(calculateGlucoseAvg(patient.diary)) < 5).length;
    int goodLength = patients.where((patient) => calculateA1c(calculateGlucoseAvg(patient.diary)) >= 5 && calculateA1c(calculateGlucoseAvg(patient.diary)) < 8).length;

    return Container(
      padding: EdgeInsets.only(left: 55, right: 55, top: 45, bottom: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Всего пациентов',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                patients.length.toString(),
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Необходима помощь',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                badLength.toString(),
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  color: Color.fromRGBO(242, 60, 60, 1)
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Нужен контроль',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                needControlLength.toString(),
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  color: Color.fromRGBO(249, 187, 30, 1)
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Всё замечательно',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                goodLength.toString(),
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

