import 'dart:ui';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/social_media/user.dart';
import 'comment.dart';

typedef Post = ({
  User creator,
  IList<Image> images,
  String text,
  bool liked,
  IList<Comment> comments,
});

extension ExtendedPost on Post {
  Post copyBy({
    bool Function(bool liked)? liked,
    IList<Comment> Function(IList<Comment> comments)? comments,
  }) => (
    creator: creator,
    images: images,
    text: text,
    liked: liked?.call(this.liked) ?? this.liked,
    comments: comments?.call(this.comments) ?? this.comments,
  );
}

