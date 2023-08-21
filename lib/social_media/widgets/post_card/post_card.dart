import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/social_media/widgets/post_card/button_row.dart';
import 'package:teaching_platform/social_media/widgets/post_card/content.dart';
import 'package:teaching_platform/social_media/widgets/post_card/creator_row.dart';
import 'package:teaching_platform/social_media/widgets/values.dart';

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
      padding: const EdgeInsets.all(cardPadding),
      decoration: cardDecoration(theme),
      child: Column(
        children: [
          CreatorRow(post.creator),
          const SizedBox(height: cardSpacing),
          Content(post),
          const SizedBox(height: cardSpacing),
          ButtonRow(
            liked: post.liked,
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
