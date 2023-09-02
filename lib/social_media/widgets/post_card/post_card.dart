import 'package:flutter/material.dart' hide Listener;
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/social_media/widgets/post_card/button_row.dart';
import 'package:teaching_platform/social_media/widgets/post_card/content.dart';
import 'package:teaching_platform/social_media/widgets/post_card/creator_row.dart';
import 'package:teaching_platform/social_media/widgets/values.dart';
import 'listener.dart';
import 'comment_section.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class PostCard extends StatelessWidget {
  final int index;
  final Post post;
  final Listener listener;

  const PostCard({
    super.key,
    required this.index,
    required this.post,
    required this.listener,
  });

  // TODO: use constants (not relative for padding?)

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      padding: const EdgeInsets.all(cardPadding),
      decoration: cardDecoration(theme),
      child: Column(
        children: <Widget>[
          CreatorRow(post.creator),
          Content(post),
          ButtonRow(
            index: index,
            liked: post.liked,
            bookmarked: false,
            listener: listener,
          ),
          if (post.comments.isNotEmpty) CommentSection(
            comments: post.comments,
          ),
        ].addBetween(const SizedBox(height: cardSpacing)),
      )
    );
  }
}
