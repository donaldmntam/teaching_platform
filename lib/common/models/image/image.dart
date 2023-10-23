import 'package:flutter/material.dart' hide Image;

typedef Image = ({
  double aspectRatio,
  ImageProvider provider,
});

Image? jsonToImage(Object? json) {
  if (
    json case {
      "aspectRatio": num encodedAspectRatio,
      "image": String imagePath,
    }
  ) {
    return (
      aspectRatio: encodedAspectRatio.toDouble(),
      provider: AssetImage(imagePath),
    );
  }
  return null;
}
