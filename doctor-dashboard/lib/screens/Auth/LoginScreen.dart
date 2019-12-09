import 'package:doctor/widgets/CommonAppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/repositories/repositories.dart';
import 'package:doctor/widgets/Auth/LoginForm.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  final AuthRepository authRepository;

  LoginScreen({Key key, @required this.authRepository})
    : assert(authRepository != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider(
        builder: (context) {
          return LoginBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            authRepository: authRepository,
          );
        },
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 680,
              maxHeight: 750,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Диабет привет',
                  style: TextStyle(
                    fontSize: 100,
                    height: 1,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 100,),
                LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

