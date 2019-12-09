import 'package:doctor/blocs/blocs.dart';
import 'package:doctor/blocs/chat/chat_bloc.dart';
import 'package:doctor/models/models.dart';
import 'package:doctor/screens/chat/Conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatItem extends StatelessWidget {
  final Chat item;

  ChatItem({this.item});

  @override
  Widget build(BuildContext context) {
    final ChatBloc _chatBloc = BlocProvider.of<ChatBloc>(context);
    String fullName = '${item.patient.first_name} ${item.patient.last_name}';

    return Material(
      child: InkWell(
        onTap: () {
          _chatBloc.add(OpenConversation(patient: item.patient));
        },
        child: Container(
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://eu.ui-avatars.com/api/?name=$fullName'
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      fullName,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      color: Colors.transparent,
    );
  }
}
