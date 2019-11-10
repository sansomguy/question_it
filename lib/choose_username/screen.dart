import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_it/buttons/circle.dart';
import 'package:question_it/settings/borders.dart';
import 'package:question_it/settings/colors.dart' as app_colors;
import 'package:question_it/users/user.dart';
import 'package:question_it/users/user_bloc.dart';

class ChooseUserNameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChooseUserNameScreen();
  }
}

class _ChooseUserNameScreen extends State<ChooseUserNameScreen>{

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: app_colors.PrimaryB,
          padding: EdgeInsets.all(20),
          child: Center(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                  return _buildTextField();
              },
            ),
          ),),
      floatingActionButton: CircleButton(
        iconData: Icons.check,
        onTap: () {
          BlocProvider.of<UserBloc>(context).add(SetUserEvent(User(controller.text)));
        },
      ),
    );
  }

  _buildTextField() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.black,
              style: BorderStyle.solid,
              width: border_width)),
      child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration.collapsed(hintText: "USERNAME")),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
