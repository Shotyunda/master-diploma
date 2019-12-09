import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 80;
  final Widget leading;
  final PreferredSize bottom;
  final List<Widget> actions;
  final Color backgroundColor;

  const CommonAppBar({Key key, this.leading, this.bottom = const PreferredSize(preferredSize: const Size.fromHeight(0), child: null,), this.actions = const [], this.backgroundColor = const Color.fromRGBO(47, 163, 156, 1)}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 15),
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: leading,
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ...actions,
                  ],
                ),
              ),
            ],
          ),
          bottom.preferredSize.height == 0 ? Container() : bottom,
        ],
      ),
    );
  }
}

