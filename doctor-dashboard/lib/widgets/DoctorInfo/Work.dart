import 'package:flutter/material.dart';

class Work extends StatefulWidget {
  final Function callback;

  Work(this.callback);

  @override
  _WorkState createState() => _WorkState(callback);
}

class _WorkState extends State<Work> {
  final Function callback;
  final _placeController = TextEditingController();
  final _courseController = TextEditingController();

  FocusNode _placeFocusNode;
  FocusNode _courseFocusNode;

  _WorkState(this.callback);

  _placeListener() {
    callback('current_work', _placeController.text);
  }

  _courseListener() {
    callback('course', _courseController.text);
  }

  @override
  void initState() {
    super.initState();
    _placeFocusNode = FocusNode();
    _placeController.addListener(_placeListener);

    _courseFocusNode = FocusNode();
    _courseController.addListener(_courseListener);
  }

  @override
  void dispose() {
    _placeFocusNode.dispose();
    _courseFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 25,),
        Text(
          'Ваша проф. деятельность',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(height: 40,),
        TextFormField(
          focusNode: _placeFocusNode,
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            labelText: 'Место работы',
            labelStyle: TextStyle(
                color: _placeFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
                fontSize: 18
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          controller: _placeController,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_courseFocusNode);
//            callback('first_name', _firstNameController.text);
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Invalid work place!';
            }
            return null;
          },
        ),
        SizedBox(height: 30,),
        TextFormField(
          focusNode: _courseFocusNode,
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            labelText: 'Специализация',
            labelStyle: TextStyle(
                color: _courseFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
                fontSize: 18
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          controller: _courseController,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
//            callback('first_name', _firstNameController.text);
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Invalid course!';
            }
            return null;
          },
        ),
      ],
    );
  }
}
