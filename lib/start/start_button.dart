import 'package:flutter/material.dart';
import 'package:question_it/settings/colors.dart' as app_colors;

enum StartButtonType { Add, Search }

class StartButton extends StatefulWidget {
  final StartButtonType buttonType;
  Function onClick;

  StartButton({this.buttonType, this.onClick});

  @override
  State<StatefulWidget> createState() {
    return _StartButtonState(buttonType: this.buttonType, onClick: this.onClick);
  }
}

class _StartButtonState extends State<StartButton>
    with SingleTickerProviderStateMixin {
  final StartButtonType buttonType;

  AnimationController _animationController;
  Animation _animation;
  Function onClick;

  _StartButtonState({this.buttonType, this.onClick});

  Animation getAnimation() {
    return ColorTween(begin: getUnpressedColor(), end: getPressedColor())
        .animate(_animationController);
  }

  Color getPressedColor() {
    return buttonType == StartButtonType.Add
        ? app_colors.PrimaryADarkened
        : app_colors.PrimaryBDarkened;
  }

  Color getUnpressedColor() {
    return buttonType == StartButtonType.Add
        ? app_colors.PrimaryA
        : app_colors.PrimaryB;
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = getAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) {
        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: _animation.value,
              border: Border.all(
                  width: 3,
                  color: buttonType == StartButtonType.Add
                      ? app_colors.PrimaryADarkened
                      : app_colors.PrimaryBDarkened),
            ),
            child: IconButton(
              onPressed: () {
                _animationController.fling(velocity: 1).whenComplete(() {
                  _animationController.reverse();
                });
                this.onClick();
              },
              iconSize: 120,
              color: Colors.black,
              icon: Icon(
                  buttonType == StartButtonType.Add ? Icons.add : Icons.search),
            ));
      },
    );
  }
}
