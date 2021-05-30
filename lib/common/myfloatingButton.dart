import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class MyFloatingButton extends StatelessWidget {
  final TabController tabController;
  List<Widget> pushableScreens = [];

  MyFloatingButton({Key key, this.tabController,this.pushableScreens}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom == 0
              ? 65.0.h
              : MediaQuery.of(context).viewPadding.bottom + 35.0.h),
      child: Visibility(
        visible: tabController.index != 2,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => pushableScreens[tabController.index]));
          },
          child: Icon(Icons.add, size: 28.0.h, color: Colors.black),
          backgroundColor: Theme.of(context).buttonColor,
        ),
      ),
    );
  }
}
