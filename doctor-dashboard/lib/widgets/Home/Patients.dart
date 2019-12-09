
import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/widgets/Home/PatientDiary.dart';
import 'package:doctor/widgets/Home/PatientItem.dart';
import 'package:doctor/widgets/Home/PatientsHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      builder: (context) => HomeBloc(authBloc: BlocProvider.of<AuthBloc>(context))..add(FetchPatientsForHome()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          List<Patient> patients = [];

          if (state is PatientsFetchedHomeState) {
            patients = state.patients;
          }

          if (state is PatientDiaryPageLoaded) {
            return PatientDiary(patient: state.patient,);
          }

          return Container(
            child: Column(
              children: <Widget>[
                PatientsHeader(patients: patients,),
                Divider(height: 1, color: Color.fromRGBO(31, 31, 31, 0.06),),
                Container(
                  padding: EdgeInsets.only(left: 80, right: 80, top: 50, bottom: 15),
                  child: patients.isEmpty ? Center(child: Text('У вас пока нет пациентов'),) : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, int index) {
                      return PatientItem(patient: patients[index]);
                    },
                    itemCount: patients.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

