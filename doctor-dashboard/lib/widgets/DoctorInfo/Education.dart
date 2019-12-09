import 'package:doctor/blocs/doctor_info/doctor_info_bloc.dart';
import 'package:doctor/blocs/doctor_info/doctor_info_state.dart';
import 'package:doctor/models/university.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Education extends StatefulWidget {
  final Function callback;

  Education(this.callback);

  @override
  _EducationState createState() => _EducationState(callback);
}

class _EducationState extends State<Education> {
  final Function callback;
  final _experienceController = TextEditingController();

  FocusNode _experienceFocusNode;
  String university;

  _EducationState(this.callback);

  @override
  void initState() {
    super.initState();

    _experienceFocusNode = FocusNode();
    _experienceController.addListener(_experienceListener);
  }

  _experienceListener() {
    callback('experience', _experienceController.text);
  }

  @override
  void dispose() {
    _experienceFocusNode.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> _generateMenuItems(dynamic infoItems) {
    List<DropdownMenuItem<String>> tempList = [];

    for (var item in infoItems) {
      tempList.add(
        DropdownMenuItem<String>(
          child: Text(item.name),
          value: item.id,
        ),
      );
    }

    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorInfoBloc, DoctorInfoState>(
      builder: (context, state) {
        List<University> universities = [];
        List<DropdownMenuItem<String>> universitiesDropdownList = [];

        if (state is FirstStepDoneInfoState) {
          universities = state.universities;
          if (university == null) {
            university = universities.first.id;
            callback('university', university);
          }
          universitiesDropdownList = _generateMenuItems(universities);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25,),
            Text(
              'Врачебный опыт',
              style: Theme.of(context).textTheme.headline,
            ),
            SizedBox(height: 40,),
            TextFormField(
              focusNode: _experienceFocusNode,
              style: TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                labelText: 'Стаж работы',
                labelStyle: TextStyle(
                    color: _experienceFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
              controller: _experienceController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
//            callback('first_name', _firstNameController.text);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Invalid experience!';
                }
                return null;
              },
            ),
            SizedBox(height: 30,),
            DropdownButtonFormField<String>(
              value: university,
              items: universitiesDropdownList,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2),
              ),
              onChanged: (String value) {
                setState(() {
                  university = value;
                });
                callback('university', university);
              },
            )
          ],
        );
      },
    );
  }
}
