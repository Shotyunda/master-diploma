import 'dart:io';

import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/helpers/functions.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/screens/chat/Conversation.dart';
import 'package:doctor/widgets/chat/ChatItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatList extends StatefulWidget {
  final baseUrl = DotEnv().env['BASE_URL'];

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final _today = DateTime.now();

  @override
  void initState() {
    IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'foo': 'bar'} // optional
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      builder: (context) => ChatBloc(authBloc: BlocProvider.of<AuthBloc>(context))..add(LoadChatList()),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          List<Chat> chats = [];

          if (state is ChatListLoaded) {
            chats = state.chatList;
          }

          if (state is ConversationOpened) {
            return Container(
              color: Colors.white,
              child: Conversation(patient: state.patient,),
            );
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 50,),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, int index) {
                    final item = chats[index];

                    return ChatItem(item: item,);
                  },
                  itemCount: chats.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

