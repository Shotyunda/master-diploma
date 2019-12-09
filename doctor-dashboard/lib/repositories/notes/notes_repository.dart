import 'package:doctor/models/models.dart';
import 'package:doctor/repositories/notes/notes_api_client.dart';
import 'package:meta/meta.dart';

class NotesRepository {
  final NotesApiClient notesApiClient;

  NotesRepository({this.notesApiClient});

  Future<List<Notes>> fetch({String token, String doctor}) async {
    return await notesApiClient.fetch(token: token, id: doctor);
  }

  Future<Notes> create({String token, dynamic record}) async {
    return await notesApiClient.create(token: token, record: record);
  }

  Future<void> delete({String token, String id}) async {
    return await notesApiClient.remove(token: token, id: id);
  }
}
