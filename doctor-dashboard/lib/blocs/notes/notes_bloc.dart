import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/repositories/notes/repositories.dart';
import 'package:http/http.dart' as http;

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final AuthBloc authBloc;
  final NotesRepository _notesRepository = NotesRepository(notesApiClient: NotesApiClient(httpClient: http.Client()));

  NotesBloc({this.authBloc});

  @override
  NotesState get initialState => InitialNotesState();

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is LoadNotes) {
      List<Notes> notes = await _notesRepository.fetch(token: authBloc.state.token, doctor: event.doctor);
      yield NotesLoaded(notes: notes);
    } else if (event is OpenCreateNotePage) {
      yield CreateNotesPageOpened();
    } else if (event is CreateNoteEvent) {
      try {
        await _notesRepository.create(token: authBloc.state.token, record: event.record);
        List<Notes> notes = await _notesRepository.fetch(token: authBloc.state.token, doctor: authBloc.state.doctor_info.toString());
        yield NotesLoaded(notes: notes);
      } catch(error) {
        print(error);
      }
    } else if (event is RemoveNote) {
      yield NoteLoading();
      try {
        await _notesRepository.delete(token: authBloc.state.token, id: event.id);
        List<Notes> notes = await _notesRepository.fetch(token: authBloc.state.token, doctor: authBloc.state.doctor_info.toString());
        yield NotesLoaded(notes: notes);
      } catch(error) {
        print(error);
      }
    }
  }
}
