import 'dart:ui';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/social_media/user.dart';

typedef Post = ({
  User creator,
  IList<Image> images,
  String text,
  bool liked,
});