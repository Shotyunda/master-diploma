import 'package:doctor/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class LeftNav extends StatefulWidget {
  @override
  _LeftNavState createState() => _LeftNavState();
}

class _LeftNavState extends State<LeftNav> {
  int selectedIndex = 0;

  Widget _buildNavItem(NavigationItem item, bool isSelected, Function callback) {
    return Material(
      color: isSelected ? Color.fromRGBO(47, 163, 156, 0.05) : Colors.transparent,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: InkWell(
        hoverColor: Color.fromRGBO(47, 163, 156, 0.05),
        onTap: callback,
        child: Container(
          padding: EdgeInsets.only(
            left: 50,
            top: 15,
            bottom: 15,
          ),
          child: Row(
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                  size: 32,
                  color: isSelected ? Theme.of(context).primaryColor : Color.fromRGBO(31, 31, 31, 0.6),
                ),
                child: item.icon,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Theme.of(context).primaryColor : Color.fromRGBO(31, 31, 31, 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _onTap(int index) {
      BlocProvider.of<BottomNavigationBloc>(context).add(
          PageTapped(index: index)
      );
    }

    List<NavigationItem> items = [
      NavigationItem(Icon(Icons.add_circle_outline), 'Пациенты'),
      NavigationItem(Icon(OMIcons.notes), 'Заметки'),
      NavigationItem(Icon(OMIcons.settings), 'Настройки'),
    ];

    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.only(
            right: 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items.map((item) {
              int itemIndex = items.indexOf(item);
              return _buildNavItem(item, selectedIndex == itemIndex, () {
                _onTap(itemIndex);
                setState(() {
                  selectedIndex = itemIndex;
                });
              });
            }).toList(),
          ),
        );
      },
    );
  }
}

class NavigationItem {
  final Icon icon;
  final String title;

  NavigationItem(this.icon, this.title);
}
