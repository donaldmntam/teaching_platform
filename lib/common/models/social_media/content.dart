import 'package:flutter/material.dart';

sealed class Content {}

final class ImageContent implements Content {
  final ImageProvider image;

  const ImageContent({required this.image});
}

final class TextContent implements Content {
  final String text;

  const TextContent({required this.text});
}