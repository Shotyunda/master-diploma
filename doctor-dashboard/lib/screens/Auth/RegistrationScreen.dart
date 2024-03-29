import 'package:doctor/widgets/CommonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/repositories/repositories.dart';
import 'package:doctor/widgets/Auth/RegistrationForm.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = '/reg';
  final AuthRepository authRepository;

  RegistrationScreen({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        leading: FlatButton.icon(
          label: Text(
            'Назад',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 16,
            ),
          ),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider(
        builder: (context) {
          return LoginBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            authRepository: authRepository,
          );
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, MediaQuery.of(context).size.height * 0.05, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Регистрация',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                RegistrationForm(),
              ],
            ),
          ),
        ),
      )
    );
  }
}

