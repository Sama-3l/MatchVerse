import 'package:flutter/cupertino.dart';

class AppColors {
  static const transparent = CupertinoColors.transparent;
  static const red = CupertinoColors.systemPink;
  static const primaryWhite = Color(0xffeaeaea);
  static const secondaryWhite = Color(0xffffffff);
  static const backgroundBlack = Color(0xff1c1c1e);
  static const surfaceBlack = Color(0xff262628);
  static const actionOrange = Color(0xffFF7F11);
  static const green = Color(0xff32D74B);
}

final LinearGradient cardGradient = LinearGradient(
  colors: [
    AppColors.secondaryWhite.withOpacity(0),
    AppColors.backgroundBlack.withOpacity(0.4),
    AppColors.backgroundBlack.withOpacity(0.8),
    AppColors.backgroundBlack.withOpacity(0.9),
  ],
  begin: const FractionalOffset(0.0, -1.0),
  end: const FractionalOffset(0.0, 1.0),
  stops: const [
    0.0,
    0.8,
    0.9,
    1.0
  ],
);
