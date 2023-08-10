import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/models/social_media/content.dart';
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/social_media/widgets/post_card/post_card.dart';

class Page extends StatefulWidget {
  final IList<Post> posts;

  const Page({
    super.key,
    required this.posts,
  });

  @override
  widgets.State<Page> createState() => _State();
}

class _State extends widgets.State<Page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: ListView.separated(
          itemCount: widget.posts.length,
          itemBuilder: (_, index) => PostCard(widget.posts[index]),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
        ),
      )
    );
  }
}