import 'package:doctor/blocs/chat/bloc.dart';
import 'package:doctor/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Conversation extends StatefulWidget {
  final Patient patient;

  Conversation({this.patient});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> with SingleTickerProviderStateMixin {
  final _messageController = TextEditingController();
  FocusNode _messageFocusNode;
  FocusNode _optionsFocusNode;
  AnimationController _controller;

  @override
  void initState() {
    _messageFocusNode = FocusNode();
    _optionsFocusNode = FocusNode();
    _controller = new AnimationController(vsync: this,duration: const Duration(milliseconds: 100), value: 0.0);
    super.initState();
  }

  bool get _isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  static const _PANEL_HEADER_HEIGHT = 0.0;

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double top = height - _PANEL_HEADER_HEIGHT;
    final double bottom = -_PANEL_HEADER_HEIGHT;
    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, top + 65, 0.0, bottom + 65),
      end: new RelativeRect.fromLTRB(0.0, top - 280, 0.0, bottom + 65),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _messageFocusNode.dispose();
    _optionsFocusNode.dispose();
    super.dispose();
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);
    String fullName = '${widget.patient.first_name} ${widget.patient.last_name}';
    List<Message> messages = [];

    return Stack(
      key: Key('stack'),
      children: <Widget>[
        Column(
          key: Key('chat-column'),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 50,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.arrow_back),
                      ),
                      onTap: () {
                        BlocProvider.of<ChatBloc>(context).add(LoadChatList());
                      },
                    ),
                  ),
                  SizedBox(width: 30,),
                  Container(
                    width: 64,
                    height: 64,
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
                  SizedBox(width: 20,),
                  Text(
                    fullName,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 1, color: Color.fromRGBO(31, 31, 31, 0.06),),
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ...messages.map((message) {
                      return Container(
                        child: Text(message.body, style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: 56,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 49,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(47, 163, 156, 0.05),
                      border: Border.all(color: Color.fromRGBO(31, 31, 31, 0.05)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
                      },
                      focusNode: _optionsFocusNode,
                      icon: IconTheme(
                        data: IconThemeData(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(Icons.apps),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                        focusNode: _messageFocusNode,
                        controller: _messageController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Сообщение',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(31, 31, 31, 0.05),),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(31, 31, 31, 0.05),),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                      onFieldSubmitted: (value) {
                          Message message = Message(body: _messageController.text, date: DateTime.now());
                          messages.add(message);

                          print(messages);

                          _messageController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        PositionedTransition(
          key: Key('positioned'),
          rect: animation,
          child: _isPanelVisible ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0)),
            ),
            padding: EdgeInsets.only(
              top: 45,
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle_outline, color: Theme.of(context).primaryColor, size: 32,),
                      label: Text(
                        'Отказ от пациента',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      )
                  ),
                  FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.format_list_bulleted, color: Theme.of(context).primaryColor, size: 32,),
                      label: Text(
                        'Посмотреть дневник',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      )
                  ),
                  FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.insert_chart, color: Theme.of(context).primaryColor, size: 32,),
                      label: Text(
                        'Посмотреть аналитику',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      )
                  ),
                ],
              ),
            ),
          ) : Container(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        Key key = Key('builder');
//        String fullName = '${widget.patient.first_name} ${widget.patient.last_name}';

        return Container(
          child: LayoutBuilder(
            key: key,
            builder: _buildStack,
          ),
        );
      },
    );
  }
}
