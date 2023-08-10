import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/social_media/widgets/post_card/button_row.dart';
import 'package:teaching_platform/social_media/widgets/post_card/content.dart';
import 'package:teaching_platform/social_media/widgets/post_card/creator_row.dart';

const _shadow = BoxShadow(
  color: Color(0x11000000),
  blurRadius: 2,
  spreadRadius: 2,
  offset: Offset(0, 1),
);

const _contentPadding = 12.0;
const _spacing = 12.0;

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard(
    this.post,
    {super.key}
  );

  // TODO: use constants (not relative for padding?)

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      padding: const EdgeInsets.all(_contentPadding),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        boxShadow: const [_shadow],
      ),
      child: Column(
        children: [
          CreatorRow(post.creator),
          const SizedBox(height: _spacing),
          ContentWidget(post.content),
          const SizedBox(height: _spacing),
          ButtonRow(
            liked: true,
            bookmarked: false,
            onLikePressed: () {}, 
            onCommentPressed: () {},
            onSharePressed: () {},
            onBookmarkPressed: () {}
          ),
        ]
      )
    );
  }
}
