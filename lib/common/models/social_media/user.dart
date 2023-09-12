import 'package:flutter/material.dart';

typedef User = ({
  String userName,
  ImageProvider picture,
});

User? jsonToUser(Object? json) {
  if (
    json case {
      "userName": String userName,
      "picture": String imageUrl,
    }
  ) {
    return (
      userName: userName,
      picture: NetworkImage(imageUrl),
    );
  }
  return null;
}
