import 'package:doctor/models/notes.dart';
import 'package:equatable/equatable.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => throw UnimplementedError();
}

class InitialNotesState extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesLoaded extends NotesState {
  final List<Notes> notes;

  NotesLoaded({this.notes});
}

class NoteLoading extends NotesState {}

class CreateNotesPageOpened extends NotesState {}
