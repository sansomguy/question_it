import 'package:flutter/material.dart';
import 'dart:math' as math;



class CustomFloatingActionButtonLocation {
  static const startDocked = _StartFloatFloatingActionButtonLocation();
}

abstract class _FloatFloatingActionButtonLocation extends FloatingActionButtonLocation {
  const _FloatFloatingActionButtonLocation();

  // Positions the Y coordinate of the [FloatingActionButton] at a height
  // where it docks to the [BottomAppBar].
  @protected
  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Compute the y-axis offset.
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;
    double fabY = contentBottom - fabHeight - kFloatingActionButtonMargin;
    if (snackBarHeight > 0.0)
      fabY = math.min(fabY, contentBottom - snackBarHeight - fabHeight - kFloatingActionButtonMargin);
    if (bottomSheetHeight > 0.0)
      fabY = math.min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);
    return fabY;
  }
}

class _StartFloatFloatingActionButtonLocation extends _FloatFloatingActionButtonLocation {
  const _StartFloatFloatingActionButtonLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = _startOffset(scaffoldGeometry);
    return Offset(fabX, getDockedY(scaffoldGeometry));
  }

  @override
  String toString() => 'FloatingActionButtonLocation.endDocked';
}


double _leftOffset(ScaffoldPrelayoutGeometry scaffoldGeometry, { double offset = 0.0 }) {
  return kFloatingActionButtonMargin
      + scaffoldGeometry.minInsets.left
      - offset;
}

double _rightOffset(ScaffoldPrelayoutGeometry scaffoldGeometry, { double offset = 0.0 }) {
  return scaffoldGeometry.scaffoldSize.width
      - kFloatingActionButtonMargin
      - scaffoldGeometry.minInsets.right
      - scaffoldGeometry.floatingActionButtonSize.width
      + offset;
}



double _startOffset(ScaffoldPrelayoutGeometry scaffoldGeometry, { double offset = 0.0 }) {
  assert(scaffoldGeometry.textDirection != null);
  switch (scaffoldGeometry.textDirection) {
    case TextDirection.rtl:
      return _rightOffset(scaffoldGeometry, offset: offset);
    case TextDirection.ltr:
      return _leftOffset(scaffoldGeometry, offset: offset);
  }
  return null;
}