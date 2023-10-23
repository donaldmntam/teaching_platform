import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/social_media/user.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

const _pictureSize = 42.0;

class CreatorRow extends StatelessWidget {
  final User creator;

  const CreatorRow(
    this.creator,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            width: _pictureSize,
            height: _pictureSize,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: theme.colors.background,
            ),
            child: Image(
              fit: BoxFit.cover,
              image: creator.picture,
              width: _pictureSize,
              height: _pictureSize,
            )
          ),
        ),
        const SizedBox(width: 12),
        Text(
          creator.userName,
          style: theme.textStyle(
            size: 20,
            weight: FontWeight.normal,
            color: theme.colors.onSurface,
          )
        ),
      ]
    );
  }
}
