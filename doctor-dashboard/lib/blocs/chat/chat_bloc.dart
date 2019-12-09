import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:doctor/blocs/auth/auth_bloc.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/repositories/chat/repositories.dart';
import 'package:http/http.dart' as http;
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository = ChatRepository(chatApiClient: ChatApiClient(httpClient: http.Client()));

  AuthBloc authBloc;

  ChatBloc({this.authBloc});

  @override
  ChatState get initialState => InitialChatState();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is LoadChatList) {
      try {
        List<Chat> chatList = await _chatRepository.list(token: authBloc.state.token);
        yield ChatListLoaded(chatList: chatList);
      } catch(error) {
        print(error);
        yield ChatFailure(error: error.toString());
      }
    } else if (event is OpenConversation) {
      yield ConversationOpened(patient: event.patient);
    }
  }
}
