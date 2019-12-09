import 'package:flutter/material.dart';

class About extends StatefulWidget {
  final Function callback;

  About(this.callback);

  @override
  _AboutState createState() => _AboutState(callback);
}

class _AboutState extends State<About> {
  final Function callback;
  final _aboutController = TextEditingController();

  FocusNode _aboutFocusNode;

  _AboutState(this.callback);

  _aboutListener() {
    callback('about', _aboutController.text);
  }

  @override
  void initState() {
    super.initState();
    _aboutFocusNode = FocusNode();
    _aboutController.addListener(_aboutListener);
  }

  @override
  void dispose() {
    _aboutFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 25,),
        Text(
          'Рассказ о себе',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(height: 10,),
        Text(
          'Завершите регистрацию небольшим рассказом о себе, чтобы пациентам было проще в выборе врача.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 40,),
        TextFormField(
          maxLines: null,
          minLines: 4,
          keyboardType: TextInputType.multiline,
          controller: _aboutController,
          focusNode: _aboutFocusNode,
          decoration: InputDecoration(
            hintText: 'Напишите о себе',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Invalid about!';
            }
            return null;
          },
        ),
      ],
    );
  }
}
