import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/social_media/user.dart';
import 'comment.dart';
import 'package:teaching_platform/common/models/image/image.dart';

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

Post? jsonToPost(Object? json) {
  if (
    json case {
      "creator": Object? encodedCreator,
      "images": List<Object?> encodedImages,
      "text": String text,
      "liked": bool liked,
      "comments": List<Object?> encodedComments,
    }
  ) {
    final creator = jsonToUser(encodedCreator);
    if (creator == null) return null;
    final images = List<Image>.empty(growable: true);
    for (final encodedImage in encodedImages) {
      final image = jsonToImage(encodedImage);
      if (image == null) return null;
      images.add(image);
    }
    final comments = List<Comment>.empty(growable: true);
    for (final encodedComment in encodedComments) {
      final comment = jsonToComment(encodedComment);
      if (comment == null) return null;
      comments.add(comment);
    }
    return (
      creator: creator,
      images: images.lock,
      text: text,
      liked: liked,
      comments: comments.lock,
    );
  }
  return null;
}

IList<Post>? jsonToPosts(Object? json) {
  if (json is! List<Object?>) return null;
  final posts = List<Post>.empty(growable: true);
  for (final encodedPost in json) {
    final post = jsonToPost(encodedPost);
    if (post == null) return null;
    posts.add(post);
  }
  return posts.lock;
}
