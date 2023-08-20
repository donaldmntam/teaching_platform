import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/theme/theme.dart';

const cardSpacing = 12.0;
const cardPadding = 12.0;
const cardShadow = BoxShadow(
  color: Color(0x11000000),
  blurRadius: 2,
  spreadRadius: 2,
  offset: Offset(0, 1),
);
BoxDecoration cardDecoration(Theme theme) => BoxDecoration(
  color: theme.colors.surface,
  boxShadow: const [cardShadow],
);
const buttonRowSpacing = 12.0;
const buttonRowHeight = 32.0;
