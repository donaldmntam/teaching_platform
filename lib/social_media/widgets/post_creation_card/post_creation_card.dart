import 'package:flutter/material.dart' hide TextButton;
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/text_field/long_text_field.dart';
import 'package:teaching_platform/social_media/widgets/post_creation_card/button_row.dart';
import 'package:teaching_platform/social_media/widgets/values.dart';

class PostCreationCard extends StatefulWidget {
  final void Function(String text) onSubmit;

  const PostCreationCard({
    super.key,
    required this.onSubmit,
  });

  @override
  State<PostCreationCard> createState() => _PostCreationCardState();
}

class _PostCreationCardState extends State<PostCreationCard> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              hint: "What's on your mind?",
              controller: controller,
            ),
          ),
          const SizedBox(height: cardSpacing),
          ButtonRow(
            onAddImagePressed: () => {},
            onSubmitPressed: () => widget.onSubmit(controller.text),
          )
        ],
      )
    );
  }
}