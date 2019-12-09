import 'package:collection/collection.dart';
import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/widgets/Home/DiaryItemWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PatientDiary extends StatelessWidget {
  final Patient patient;

  PatientDiary({this.patient});

  @override
  Widget build(BuildContext context) {
    patient.diary.sort((record1, record2) => DateTime.parse(record2.date).compareTo(DateTime.parse(record1.date)));
    var list = groupBy(patient.diary, (item) => DateFormat('dd.MM.yyyy').format(DateTime.parse(item.date)));

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton.icon(onPressed: () {
                  BlocProvider.of<HomeBloc>(context)..add(FetchPatientsForHome());
                }, icon: Icon(Icons.arrow_back), label: Text('Список всех пациентов')),
                SizedBox(height: 30,),
                Row(
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
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Color.fromRGBO(31, 31, 31, 0.06),),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, position) {
                List<dynamic> keys = list.keys.toList();
                return DiaryItemWrapper(diaryItems: list[keys[position]], date: keys[position],);
              },
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }
}
