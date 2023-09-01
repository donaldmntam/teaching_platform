import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/theme/theme.dart';

const maxRetryCount = 1;

BoxDecoration panelDecoration(Theme theme) => BoxDecoration(
  color: theme.colors.surface,
  borderRadius: const BorderRadius.all(Radius.circular(8)),
  boxShadow: const [
    BoxShadow(
      color: Color(0x10000000),
      spreadRadius: 2,
      blurRadius: 2,
      offset: Offset(0, 2),
    )
  ]
);

const panelSpacing = 12.0;

TextStyle panelTextStyle(Theme theme) => theme.textStyle(
  size: 20,
  weight: FontWeight.bold,
  color: theme.colors.onSurface,
);

