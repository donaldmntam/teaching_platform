import 'user.dart';

typedef Comment = ({
  User creator,
  String text,
});

Comment? jsonToComment(Object? json) {
  if (
    json case {
      "creator": Object? encodedCreator,
      "text": String text,
    }
  ) {
    final creator = jsonToUser(encodedCreator);
    if (creator == null) return null;
    return (
      creator: creator,
      text: text,
    );
  }
  return null;
}
