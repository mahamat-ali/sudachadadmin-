import 'package:flutter/material.dart';

ButtonStyle bntStyle(BuildContext context, Color color) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(color),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    ),
    textStyle: MaterialStateProperty.all(
      TextStyle(
        fontSize: 28.0,
      ),
    ),
  );
}
