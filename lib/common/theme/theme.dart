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
    double? letterSpacing,
  }) => TextStyle(
    fontFamily: baseTextStyle.fontFamily,
    fontSize: size,
    color: color,
    decoration: decoration,
    overflow: overflow,
    fontWeight: weight,
    letterSpacing: letterSpacing,
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
    background: Color.fromARGB(255, 240, 240, 240),
    onBackground: Color.fromARGB(255, 95, 95, 95),
    disabled: Color.fromARGB(255, 67, 67, 67),
    onDisabled: Color.fromARGB(255, 255, 255, 255),
  ),
  baseTextStyle: (
    fontFamily: "Ubuntu",
  )
);
