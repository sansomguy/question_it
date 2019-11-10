import 'package:flutter/material.dart';
import 'package:question_it/buttons/circle.dart';
import 'package:question_it/settings/borders.dart';
import 'package:question_it/settings/colors.dart' as app_colors;

class ChooseUserNameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: app_colors.PrimaryB,
          padding: EdgeInsets.all(20),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: border_width)),
              child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration.collapsed(hintText: "USERNAME")),
            ),
          )),
      floatingActionButton: CircleButton(
        iconData: Icons.check,
      ),
    );
  }
}
