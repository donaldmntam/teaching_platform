import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/theme/theme.dart';

import 'clock.dart';

class Services extends InheritedWidget {
  final Theme theme;
  final Clock clock;

  const Services({
    super.key,
    this.theme = defaultTheme,
    this.clock = const DefaultClock(),
    required super.child
  });

  static Services? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Services>();
  }

  static Services of(BuildContext context) {
    final Services? result = maybeOf(context);
    assert(result != null, 'No Services found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}