import 'package:doctor/blocs/auth/auth_bloc.dart';
import 'package:doctor/blocs/auth/blocs.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/screens/SplashScreen.dart';
import 'package:doctor/widgets/CommonAppBar.dart';
import 'package:doctor/widgets/CommonButton.dart';
import 'package:doctor/widgets/DoctorInfo/About.dart';
import 'package:doctor/widgets/DoctorInfo/Education.dart';
import 'package:doctor/widgets/DoctorInfo/PersonalInfo.dart';
import 'package:doctor/widgets/DoctorInfo/Thanks.dart';
import 'package:doctor/widgets/DoctorInfo/Work.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/blocs/doctor_info/bloc.dart';

class DoctorInfo extends StatefulWidget {
  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  static final _form = GlobalKey<FormState>();
  var _data = {
    'first_name': '',
    'last_name': '',
    'birthday': '',
    'sex': 'male',
    'experience': '',
    'current_work': '',
    'course': '',
    'about': '',
    'university': '',
  };

  _callback(String name, String value) {
    if (value.isNotEmpty) _data[name] = name == 'birthday' ? DateTime.parse(value).toIso8601String() : value;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorInfoBloc>(
      builder: (context) {
        return DoctorInfoBloc(
          authBloc: BlocProvider.of<AuthBloc>(context),
        )..add(ToInitialDoctorInfo());
      },
      child: BlocListener<DoctorInfoBloc, DoctorInfoState>(
        listener: (context, state) {},
        child: BlocBuilder<DoctorInfoBloc, DoctorInfoState>(
          builder: (context, state) {
            _nextStepCallback() {
              if (!_form.currentState.validate()) {
                return;
              }
              _form.currentState.save();
              if (state is FirstStepDoctorInfoState) {
                BlocProvider.of<DoctorInfoBloc>(context).add(FirstStepDone());
              }
              if (state is FirstStepDoneInfoState) {
                BlocProvider.of<DoctorInfoBloc>(context).add(SecondStepDone());
              }
              if (state is SecondStepDoneInfoState) {
                BlocProvider.of<DoctorInfoBloc>(context).add(ThirdStepDone());
              }
              if (state is ThreeStepDoneInfoState) {
                BlocProvider.of<DoctorInfoBloc>(context).add(SaveDoctorInfo(record: _data));
              }
              if (state is FourStepDoneInfoState) {
                BlocProvider.of<AuthBloc>(context).add(AppStarted());
              }
            }

            _backButtonCallback() {
              if (state is FirstStepDoneInfoState) {
                BlocProvider.of<DoctorInfoBloc>(context).add(ToInitialDoctorInfo());
              }
              if (state is SecondStepDoneInfoState) {
                BlocProvider.of<DoctorInfoBloc>(context).add(FirstStepDone());
              }
              if (state is ThreeStepDoneInfoState) {
                BlocProvider.of<DoctorInfoBloc>(context).add(SecondStepDone());
              }
            }

            return Scaffold(
              backgroundColor: state.step == 4 ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
              appBar: CommonAppBar(
                backgroundColor: state.step == 4 ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
                leading: state.step > 0 && state.step < 4 ? FlatButton.icon(
                  onPressed: _backButtonCallback,
                  icon: Icon(Icons.arrow_back),
                  label: Text('Назад'),
                ) : Container(),
                actions: <Widget>[
                  Text(
                    '${state.step + 1} / 5',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: state.step == 4 ? Colors.white : Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(state.step < 4 ? 10 : 0),
                  child: LinearProgressIndicator(
                    value: state.progress,
                    backgroundColor: Color.fromRGBO(242, 243, 255, 1),
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        state is FirstStepDoctorInfoState
                            ? PersonalInfo(_callback) : state is FirstStepDoneInfoState
                            ? Education(_callback) : state is SecondStepDoneInfoState
                            ? Work(_callback) : state is ThreeStepDoneInfoState
                            ? About(_callback) : state is FourStepDoneInfoState
                            ? Thanks() : Center(child: CircularProgressIndicator(),),
                        CommonButton(
                          onPressed: _nextStepCallback,
                          isPrimaryFilled: state.step != 4,
                          isPrimary: state.step == 4,
                          text: state.step == 4 ? 'В приложение' : 'Вперед',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
