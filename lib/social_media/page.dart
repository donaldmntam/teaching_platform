import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/models/social_media/content.dart';
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/social_media/widgets/post_card/post_card.dart';
import 'package:teaching_platform/social_media/widgets/post_creation_card/post_creation_card.dart';

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
    final widgets = _widgets(posts: widget.posts, onSubmit: (_) {});
    
    return ClipRect(
      child: Center(
        child: SizedBox(
          width: 500,
          child: ListView.separated(
            clipBehavior: Clip.none,
            itemCount: widgets.length,
            itemBuilder: (_, index) => widgets[index],
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        )
      ),
    );
  }
}

List<Widget> _widgets({
  required IList<Post> posts,
  required void Function(String text) onSubmit,
}) {
  final widgets = List<Widget>.empty(growable: true);
  
  widgets.add(PostCreationCard(onSubmit: onSubmit));
  widgets.addAll(posts.map((post) => PostCard(post)));

  return widgets;
}
