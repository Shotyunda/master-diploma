import 'package:doctor/blocs/auth/blocs.dart';
import 'package:doctor/blocs/notes/bloc.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/widgets/Notes/CreateNote.dart';
import 'package:doctor/widgets/Notes/NotesItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      builder: (context) => NotesBloc(authBloc: BlocProvider.of<AuthBloc>(context))..add(LoadNotes(doctor: BlocProvider.of<AuthBloc>(context).state.doctor_info.toString(),)),
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          List<Notes> notes = [];

          if (state is NotesLoaded) {
            notes = state.notes;
          }

          if (state is CreateNotesPageOpened) {
            return CreateNote();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: GridView.count(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(8.0),
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 2,
                  children: notes.map((notes) => NotesItem(note: notes,)).toList(),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 100,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    hoverColor: Color.fromRGBO(47, 163, 156, 0.05),
                    onTap: () {
                      BlocProvider.of<NotesBloc>(context)..add(OpenCreateNotePage());
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Создать новую заметку'),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
