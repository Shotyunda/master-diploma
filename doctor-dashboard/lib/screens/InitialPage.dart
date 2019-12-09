import 'package:doctor/helpers/functions.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/screens/chat/ChatList.dart';
import 'package:doctor/widgets/Home/Patients.dart';
import 'package:doctor/widgets/LeftNav.dart';
import 'package:doctor/widgets/Notes/NotesList.dart';
import 'package:doctor/widgets/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/blocs/blocs.dart';
//import 'package:doctor/screens/Diary/DiaryScreen.dart';
//import 'package:doctor/screens/HomeScreen.dart';
import 'package:doctor/widgets/BottomNav.dart';

import 'Home.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBloc>(
          builder: (context) => BottomNavigationBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
          ),
        ),
        BlocProvider<HomeBloc>(
          builder: (context) => HomeBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Builder(
          builder: (ctx) {
            final _today = DateTime.now();

            return Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(36, 36, 45, 0.06),
                              blurRadius: 40,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                Doctor doctor;
                                String fullName;

                                if (state is AuthenticationAuthenticated) {
                                  doctor = state.doctor;
                                  fullName = '${doctor.first_name} ${doctor.last_name}';
                                }
                                return Container(
                                  padding: EdgeInsets.all(50),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              'https://eu.ui-avatars.com/api/?name=$fullName',
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 40,),
                                      Text(
                                        fullName,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              padding: EdgeInsets.all(50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        getWeekDay(_today.weekday),
                                        style: TextStyle(
                                          fontSize: 50,
                                          height: 1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        getDate(_today, _today.month),
                                        style: TextStyle(
                                          fontSize: 30,
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Нет ближайших событий',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                              builder: (context, state) {
                                return LeftNav();
                              },
                            ),
                            SizedBox(height: 100,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.notifications_none, color: Color.fromRGBO(31, 31, 31, 0.6), size: 32,),
                                  SizedBox(width: 20,),
                                  Text(
                                    'Сегодня 0 событий на день',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(36, 36, 45, 0.06),
                              blurRadius: 40,
                            ),
                          ],
                        ),
                        child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                          builder: (context, state) {
                            if (state is HomePageLoaded) {
                              return PatientsWidget();
                            } else if (state is NotesPageLoaded) {
                              return NotesList();
                            } else if (state is SettingPageLoaded) {
                              return Settings();
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(36, 36, 45, 0.06),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ChatList(),
                    ),
                  ),
                ],
              ),
            );
//                if (state is HomePageLoaded) {
//                  return Home();
//                }
//                if (state is ChatPageLoaded) {
//                  return ChatList();
//                }
//                return Container();
          },
        ),
      ),
    );
  }
}

