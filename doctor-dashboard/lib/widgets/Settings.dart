import 'package:doctor/blocs/auth/auth_bloc.dart';
import 'package:doctor/blocs/auth/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 50),
          child: FlatButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context)..add(LoggedOut());
            },
            child: Text('Выйти'),
          ),
        ),
      ],
    );
  }
}
