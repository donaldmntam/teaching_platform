import 'package:flutter/material.dart' hide Theme, Listener;
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/image_picker.dart';
import 'package:teaching_platform/common/models/social_media/user.dart';

import 'clock.dart';
import 'listener.dart';

class Services extends InheritedWidget {
  final User? user;
  final Theme theme;
  final Clock clock;
  final ImagePicker imagePicker;
  final Listener listener;

  Services({
    super.key,
    this.user,
    this.theme = defaultTheme,
    this.clock = const DefaultClock(),
    ImagePicker? imagePicker,
    required this.listener,
    required super.child
  }) :
    imagePicker = DefaultImagePicker();

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

