import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/social_media/content.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/loading_indicator/loading_indicator.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

class ContentWidget extends StatelessWidget {
  final Content content;

  const ContentWidget(
    this.content,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return SizedBox(
      width: double.infinity,
      child: switch (content) {
        TextContent(text: final text) => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colors.background,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: theme.textStyle(
              size: 16,
              weight: FontWeight.normal,
              color: theme.colors.onSurface,
            )
          )
        ),
        // TODO: use image aspect ratio instead
        ImageContent(image: final image) => AspectRatio(
          aspectRatio: 4 / 3,
          child: Image(
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return const Center(child: LoadingIndicator());
            },
            errorBuilder: (_, __, ___) => Text("error"),
            image: image,
          )
        ),
      },
    );
  }
}