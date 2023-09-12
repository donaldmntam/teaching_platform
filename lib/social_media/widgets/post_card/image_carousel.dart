import 'package:carousel_slider/carousel_slider.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/material.dart' as flutter show Image;
import 'package:teaching_platform/common/models/image/image.dart';

import 'package:teaching_platform/common/widgets/services/services.dart';

class ImageCarousel extends StatefulWidget {
  final IList<Image> images;

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
          flutter.Image(
            image: image.provider,
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

double _aspectRatio(IList<Image> images) {
  var maxAspectRatio = images[0].aspectRatio;
  for (var i = 1; i < images.length; i++) {
    final aspectRatio = images[i].aspectRatio;
    if (aspectRatio > maxAspectRatio) maxAspectRatio = aspectRatio;
  }
  return maxAspectRatio;
}
