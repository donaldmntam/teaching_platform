import 'package:flutter/material.dart' hide Colors;

import 'base_text_style.dart';
import 'colors.dart';

typedef Theme = ({
  Colors colors,
  BaseTextStyle baseTextStyle,
});

extension ExtendedTheme on Theme {
  TextStyle textStyle({
    required double size,
    required FontWeight weight,
    required Color color,
    TextDecoration decoration = TextDecoration.none,
    TextOverflow? overflow = TextOverflow.ellipsis,
  }) => TextStyle(
    fontFamily: baseTextStyle.fontFamily,
    fontSize: size,
    color: color,
    decoration: decoration,
    overflow: overflow,
  );
}

const Theme defaultTheme = (
  colors: (
    primary: Color.fromARGB(255, 0, 106, 255),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    secondary: Color.fromARGB(255, 255, 208, 0),
    onSecondary: Color.fromARGB(255, 255, 255, 255),
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Color.fromARGB(255, 0, 0, 0),
    background: Color(0xFFFFFFFF),
    onBackground: Color.fromARGB(255, 95, 95, 95),
  ),
  baseTextStyle: (
    fontFamily: "arial"
  )
);