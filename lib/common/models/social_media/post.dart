import 'package:teaching_platform/common/models/social_media/user.dart';

import 'content.dart';

typedef Post = ({
  User creator,
  Content content,
  bool liked,
});