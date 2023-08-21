import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/common/util_classes/channel.dart';
import 'package:teaching_platform/social_media/widgets/post_card/post_card.dart';
import 'package:teaching_platform/social_media/widgets/post_creation_card/message.dart';
import 'package:teaching_platform/social_media/widgets/post_creation_card/post_creation_card.dart';
import 'dart:ui' as ui;

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  widgets.State<Page> createState() => _State();
}

class _State extends widgets.State<Page> {
  IList<Post> posts = _initialPosts;
  final channel = Channel<PostCreationCardMessage>();

  void onSubmit(String text, IList<ui.Image> images) {
    final Post newPost = (
      creator: (userName: "donaldtam", picture: NetworkImage("https://picsum.photos/100")),
      text: text,
      images: images,
      liked: false,
    );
    setState(() => posts = [newPost, ...posts].lock);
    channel.add(PostCreationCardMessage.clear);
  }

  @override
  Widget build(BuildContext context) {
    final widgets = _widgets(
      posts: posts,
      channel: channel,
      onSubmit: onSubmit,
    );
    
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
  required Channel<PostCreationCardMessage> channel,
  required void Function(String text, IList<ui.Image> images) onSubmit,
}) {
  final widgets = List<Widget>.empty(growable: true);
  
  widgets.add(
    PostCreationCard(
      channel: channel,
      onSubmit: onSubmit,
    )
  );
  widgets.addAll(posts.map((post) => PostCard(post)));

  return widgets;
}

final _initialPosts = <Post>[
  (
    creator: (userName: "donaldtam", picture: const NetworkImage("https://picsum.photos/100")),
    text: "This is my first post ever!",
    images: <ui.Image>[].lock,
    liked: true,
  ),
  (
    creator: (userName: "jackson123", picture: const NetworkImage("https://picsum.photos/100")),
    text: "This is my first post ever!",
    images: <ui.Image>[].lock,
    liked: false,
  ),
].lock;
