import 'package:flutter/material.dart' hide Image;

typedef Image = ({
  double aspectRatio,
  ImageProvider provider,
});

Image? jsonToImage(Object? json) {
  if (
    json case {
      "aspectRatio": num encodedAspectRatio,
      "image": String imageUrl,
    }
  ) {
    return (
      aspectRatio: encodedAspectRatio.toDouble(),
      provider: NetworkImage(imageUrl),
    );
  }
  return null;
}
