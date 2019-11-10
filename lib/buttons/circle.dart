import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_it/settings/borders.dart';


class CircleButton extends StatefulWidget {

  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CircleButton();
  }
}

class _CircleButton extends State<CircleButton> {
  bool selected = false;
  final animationDuration = Duration(milliseconds: 50);

  @override
  Widget build(BuildContext context) {
    double size = kToolbarHeight;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = true;
          Future.delayed(animationDuration, () {
            setState(() {
              selected = false;
            });
          });
        });
        this.widget.onTap();
      },
      child: AnimatedContainer(
        width: size,
        height: size,
        duration: animationDuration,
        decoration: BoxDecoration(
            color: selected ? Colors.blueGrey : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, style: BorderStyle.solid, width: border_width)
        ),
        child: Container(
          child: Icon(
            this.widget.iconData,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}