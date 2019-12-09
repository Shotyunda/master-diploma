import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesItem extends StatelessWidget {
  final Notes note;

  NotesItem({this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 50,
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete, color: Theme.of(context).primaryColorLight,),
                    onPressed: () {
                      BlocProvider.of<NotesBloc>(context)..add(RemoveNote(id: note.id));
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(note.name,),
                    Text(note.body,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
