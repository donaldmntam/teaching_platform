import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide TextButton;
import 'package:teaching_platform/common/util_classes/channel.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/text_field/long_text_field.dart';
import 'package:teaching_platform/social_media/widgets/post_creation_card/button_row.dart';
import 'package:teaching_platform/social_media/widgets/post_creation_card/image_row.dart';
import 'package:teaching_platform/social_media/widgets/post_creation_card/message.dart';
import 'package:teaching_platform/social_media/widgets/values.dart';
import 'dart:ui' as ui;

class PostCreationCard extends StatefulWidget {
  final Channel<PostCreationCardMessage> channel;
  final void Function(String text, IList<ui.Image>) onSubmit;

  const PostCreationCard({
    super.key,
    required this.channel,
    required this.onSubmit,
  });

  @override
  State<PostCreationCard> createState() => _PostCreationCardState();
}

class _PostCreationCardState extends State<PostCreationCard> {
  final controller = TextEditingController();
  IList<ui.Image> images = const IListConst([]);

  @override
  void initState() {
    widget.channel.listen((message) {
      switch (message) {
        case PostCreationCardMessage.clear:
          controller.clear();
          setState(() => images = const IListConst([]));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    widget.channel.stopListening();
    super.dispose();
  }

  void onAddImagesPressed() async {
    final services = Services.of(context);
    final images = await services.imagePicker.imagesFromPicker();
    if (!mounted) return;
    setState(() => this.images = images.lock + this.images);
  }

  void onDeleteImagePressed(int index) {
    setState(() {
      final newImages = images.removeAt(index);
      images[index].dispose();
      images = newImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      decoration: cardDecoration(theme),
      padding: const EdgeInsets.all(cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 100,
            child: LongTextField(
              singleLine: false,
              hint: "What's on your mind?",
              controller: controller,
            ),
          ),
          ButtonRow(
            onAddImagesPressed: onAddImagesPressed,
            onSubmitPressed: () => widget.onSubmit(
              controller.text,
              images,
            ),
          ),
          if (images.isNotEmpty) ...[
            ImageRow(
              images: images, 
              onDeleteImagePressed: onDeleteImagePressed
            )
          ],
        ].addBetween(const SizedBox(height: cardSpacing)),
      )
    );
  }
}
