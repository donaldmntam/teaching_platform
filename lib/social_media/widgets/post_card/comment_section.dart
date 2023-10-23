import 'package:flutter/material.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/social_media/comment.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/theme/theme.dart';

class CommentSection extends StatelessWidget {
  final IList<Comment> comments; 

  const CommentSection({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Column(
      children: comments.map<Widget>((comment) =>
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
              ),
              child: Image(
                image: comment.creator.picture,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.creator.userName,
                    style: theme.textStyle(
                      size: 18,
                      weight: FontWeight.bold,
                      color: theme.colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.text,
                    style: theme.textStyle(
                      size: 18,
                      weight: FontWeight.normal,
                      color: theme.colors.onSurface,
                    ),
                    maxLines: 50,
                  )
                ]
              ),
            )
          ]
        )
      ).toList().addBetween(const SizedBox(height: 14)),
    );
  }
}

