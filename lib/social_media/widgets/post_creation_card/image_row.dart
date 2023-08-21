import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'dart:ui' as ui;

import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';

const _borderWidth = 3.0;
const _iconSize = 14.0;

class ImageRow extends StatelessWidget {
  final IList<ui.Image> images;
  final void Function(int index) onDeleteImagePressed;

  const ImageRow({
    super.key,
    required this.images,
    required this.onDeleteImagePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children: images.mapIndexed((index, image) {
          final image = images[index];
          return Container(
            height: 80,
            padding: const EdgeInsets.all(_borderWidth),
            child: AspectRatio(
              aspectRatio: image.width / image.height,
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: theme.colors.background,
                        width: _borderWidth,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RawImage(image: image)
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: _Button(index, onDeleteImagePressed),
                    )
                  ),
                ],
              ),
            ),
          );
        },
      ).toList()),
    );
  }
}

class _Button extends StatelessWidget {
  final int index;
  final void Function(int index) onDeleteImagePressed;

  const _Button(this.index, this.onDeleteImagePressed);

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Tappable(
      onTap: () => onDeleteImagePressed(index),
      child: Opacity(
        opacity: 0.8,
        child: Container(
          alignment: Alignment.center,
          width: _iconSize,
          height: _iconSize,
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: theme.colors.surface,
          ),
          child: Icon(
            Icons.close, 
            color: theme.colors.onSurface,
            size: _iconSize * 0.8,
          ),
        ),
      ),
    );
  }
}
