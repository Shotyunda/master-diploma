import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/helpers/functions.dart';
import 'package:doctor/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientItem extends StatelessWidget {
  final Patient patient;

  PatientItem({this.patient}) : assert(patient != null);

  @override
  Widget build(BuildContext context) {
    double avg = calculateGlucoseAvg(patient.diary);
    double a1c = calculateA1c(avg);

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(31, 31, 31, 0.06), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://eu.ui-avatars.com/api/?name=${patient.first_name} ${patient.last_name}'
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${patient.first_name} ${patient.last_name}',
                      style: TextStyle(
                          fontSize: 20,
                          height: 1
                      ),
                    ),
                    Text(
                      patient.type.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(31, 31, 31, 0.6),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Состояние',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(31, 31, 31, 0.6),
                                ),
                              ),
                              Text(
                                getA1cSubTitle(a1c),
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1,
                                  color: getColorFromGlucose(avg),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 50,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'HbA1C',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(31, 31, 31, 0.6),
                                ),
                              ),
                              Text(
                                '${a1c.toStringAsFixed(1)}%',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1,
                                  color: getColorFromGlucose(avg),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 202,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    hoverColor: Color.fromRGBO(47, 163, 156, 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Аналитика'.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, height: 2),),
                          SizedBox(width: 10,),
                          Icon(Icons.show_chart, color: Theme.of(context).primaryColor,)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<HomeBloc>(context)..add(OpenDiaryPage(patient: patient));
                    },
                    hoverColor: Color.fromRGBO(47, 163, 156, 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Дневник'.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, height: 2),),
                          SizedBox(width: 10,),
                          Icon(Icons.list, color: Theme.of(context).primaryColor,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
