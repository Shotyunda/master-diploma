import 'package:doctor/models/models.dart';
import 'package:doctor/repositories/chat/chat_api_client.dart';
import 'package:meta/meta.dart';

class ChatRepository {
  final ChatApiClient chatApiClient;

  ChatRepository({this.chatApiClient});

  Future<List<Chat>> list({@required String token}) async {
    return await chatApiClient.fetch(token: token);
  }
}
