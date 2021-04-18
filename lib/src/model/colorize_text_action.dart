import 'package:flutter/material.dart';

class ColorizeTextAction<T> {
  final TextStyle textStyle;
  final Function(T) onPressed;
  final String replacementText;
  final T data;

  ColorizeTextAction(
      {this.textStyle, this.onPressed, this.replacementText, this.data});
}