import 'package:carousel_slider/carousel_slider.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:teaching_platform/common/widgets/services/services.dart';

class ImageCarousel extends StatefulWidget {
  final IList<ui.Image> images;

  const ImageCarousel({
    super.key,
    required this.images,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      color: theme.colors.background,
      child: CarouselSlider(
        items: widget.images.map((image) => 
          RawImage(
            image: image,
            fit: BoxFit.contain,
          )
        ).toList(),
        options: CarouselOptions(
          aspectRatio: _aspectRatio(widget.images),
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
        )
      ),
    );
  }
}

double _aspectRatio(IList<ui.Image> images) {
  var maxAspectRatio = images[0].width / images[0].height;
  for (var i = 1; i < images.length; i++) {
    final aspectRatio = images[i].width / images[i].height;
    if (aspectRatio > maxAspectRatio) maxAspectRatio = aspectRatio;
  }
  return maxAspectRatio;
}
