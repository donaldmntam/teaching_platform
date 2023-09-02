import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/loading_indicator/loading_indicator.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/social_media/widgets/post_card/image_carousel.dart';
import 'package:teaching_platform/social_media/widgets/values.dart';

class Content extends StatelessWidget {
  final Post post;

  const Content(
    this.post,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return SizedBox(
      width: double.infinity,
      child: switch (post.images.length) {
        0 => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colors.background,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            post.text,
            style: theme.textStyle(
              size: 16,
              weight: FontWeight.normal,
              color: theme.colors.onBackground,
            ),
            maxLines: 50,
          )
        ),
        _ => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(images: post.images),
            Text(
              post.text,
              style: theme.textStyle(
                size: 14,
                weight: FontWeight.normal,
                color: theme.colors.onSurface,
              ),
              maxLines: 50,
            )
          ].addBetween(const SizedBox(height: cardSpacing)),
        ),
      }
    );
  }
}
