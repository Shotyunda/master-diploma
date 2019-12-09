import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => throw UnimplementedError();
}

class LoadNotes extends NotesEvent {
  final String doctor;

  LoadNotes({this.doctor});
}

class OpenCreateNotePage extends NotesEvent {}

class CreateNoteEvent extends NotesEvent {
  final dynamic record;

  CreateNoteEvent({this.record});
}

class RemoveNote extends NotesEvent {
  final String id;

  RemoveNote({this.id});
}
