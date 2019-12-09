import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/helpers/functions.dart';
import 'package:doctor/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final _today = DateTime.now();

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

          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              title: Row(
                children: <Widget>[
                  Text(
                    getWeekDay(_today.weekday),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    getDate(_today, _today.month),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              actions:  <Widget>[
                FlatButton.icon(
                    onPressed: () {},
                    icon: IconTheme(
                      data: IconThemeData(
                        color: Theme.of(context).primaryColorLight,
                        size: 32,
                      ),
                      child: Icon(
                        Icons.notifications_none,
                      ),
                    ),
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'У вас 0',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'событий',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 25,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 30),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 161,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Всего',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'пациентов',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                patients.length.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Необходима',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'помощь',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                patients.length.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Нужен',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'контроль',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                patients.length.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Всё',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'замечательно',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                patients.length.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(),
                      SizedBox(height: 20,),
                      [].isEmpty ? Center(child: Text('У вас пока нет пациентов'),) : ListView.builder(
                        itemBuilder: (BuildContext ctx, int index) {
                          return Container();
                        },
                        itemCount: 0,
                      ),
                    ],
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

