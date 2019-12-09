import 'package:doctor/blocs/auth/blocs.dart';
import 'package:doctor/blocs/notes/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  var note = {
    'name': '',
    'body': '',
    'doctor': 0,
  };

  @override
  void initState() {
    _nameController.addListener(() {
      note['name'] = _nameController.text;
    });

    _bodyController.addListener(() {
      note['body'] = _bodyController.text;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        _createNote() {
          _form.currentState.save();

          note['doctor'] = BlocProvider.of<AuthBloc>(context).state.doctor_info;
          BlocProvider.of<NotesBloc>(context)..add(CreateNoteEvent(record: note));
        }

        return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton.icon(onPressed: () {
                        BlocProvider.of<NotesBloc>(context).add(LoadNotes(doctor: BlocProvider.of<AuthBloc>(context).state.doctor_info.toString(),));
                      }, icon: Icon(Icons.arrow_back), label: Text('Назад')),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _createNote,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('СОЗДАТЬ НАПОМИНАНИЕ', style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12,
                                  height: 2,
                                  fontWeight: FontWeight.bold,
                                ),),
                                SizedBox(width: 5,),
                                Icon(Icons.notifications, color: Theme.of(context).primaryColor, size: 20,)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Название',
                            hintStyle: TextStyle(
                              fontSize: 34,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _bodyController,
                          maxLines: null,
                          minLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Текст',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}

