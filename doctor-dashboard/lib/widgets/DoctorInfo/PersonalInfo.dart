import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class PersonalInfo extends StatefulWidget {
  final Function callback;

  PersonalInfo(this.callback);

  @override
  _PersonalInfoState createState() => _PersonalInfoState(callback);
}

class _PersonalInfoState extends State<PersonalInfo> {
  final Function callback;
  List<bool> _isSelected;

  FocusNode _firstNameFocusNode;
  FocusNode _lastNameFocusName;
  FocusNode _birthdayFocusNode;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();

  _PersonalInfoState(this.callback);

  @override
  void initState() {
    super.initState();

    _firstNameFocusNode = FocusNode();
    _firstNameController.addListener(_firstNameListener);

    _lastNameFocusName = FocusNode();
    _lastNameController.addListener(_lastNameListener);

    _birthdayFocusNode = FocusNode();
    _birthdayController.addListener(_birthdayListener);

    _isSelected = [true, false];
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusName.dispose();
    _birthdayFocusNode.dispose();
    super.dispose();
  }

  _firstNameListener() {
    callback('first_name', _firstNameController.text);
  }

  _lastNameListener() {
    callback('last_name', _lastNameController.text);
  }

  _birthdayListener() {
    callback('birthday', _birthdayController.text);
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        SizedBox(height: 25,),
        Text(
          'Персональные данные',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(height: 40,),
        TextFormField(
          focusNode: _firstNameFocusNode,
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            labelText: 'Имя',
            labelStyle: TextStyle(
                color: _firstNameFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
          controller: _firstNameController,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
//            callback('first_name', _firstNameController.text);
            FocusScope.of(context).requestFocus(_lastNameFocusName);
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Invalid first name!';
            }
            return null;
          },
        ),
        SizedBox(height: 30,),
        TextFormField(
          focusNode: _lastNameFocusName,
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            labelText: 'Фамилия',
            labelStyle: TextStyle(
                color: _lastNameFocusName.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
          controller: _lastNameController,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
//            callback('first_name', _firstNameController.text);
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Invalid last name!';
            }
            return null;
          },
        ),
        SizedBox(height: 30,),
        TextFormField(
          focusNode: _birthdayFocusNode,
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            labelText: 'День рождения',
            labelStyle: TextStyle(
                color: _birthdayFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
            suffixIcon: IconButton(
              icon: Icon(
                Icons.calendar_today,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          controller: _birthdayController,
          textInputAction: TextInputAction.next,
          readOnly: true,
          onTap: () {
            DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                locale: LocaleType.ru,
                onConfirm: (date) {
                  _birthdayController.value = TextEditingValue(text: DateFormat('yyyy-MM-dd').format(date));
                }
            );
          },
          keyboardType: TextInputType.datetime,
          validator: (value) {
            if (value.isEmpty) {
              return 'Invalid birthday!';
            }
            return null;
          },
        ),
        SizedBox(height: 30,),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Гендера только 2',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 20,
              ),
              ToggleButtons(
                isSelected: _isSelected,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderColor: Colors.transparent,
                selectedColor: Colors.white,
                fillColor: Theme.of(context).primaryColor,
                color: Theme.of(context).primaryColor,
                children: <Widget>[
                  Container(
                    width: (deviceWidth - 33) / 2,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Color.fromRGBO(47, 163, 156, 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Мужской',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: (deviceWidth - 33) / 2,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Color.fromRGBO(47, 163, 156, 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Женский',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _isSelected.length; i++) {
                      if (i == index) {
                        _isSelected[i] = true;
                      } else {
                        _isSelected[i] = false;
                      }
                    }
                  });
                  callback('sex', _isSelected[0] ? 'male' : 'female');
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 30,)
      ],
    );
  }
}
