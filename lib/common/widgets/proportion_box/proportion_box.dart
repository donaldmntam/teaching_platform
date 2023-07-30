import 'package:flutter/material.dart';

import 'box.dart';

class ProportionBox extends SingleChildRenderObjectWidget {
  final double proportion;

  const ProportionBox({
    super.key,
    required this.proportion,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    final box = Box();
    box.proportion = proportion;
    return box;
  }

  @override
  void updateRenderObject(BuildContext context, Box renderObject) {
    renderObject.proportion = proportion;
    renderObject.markNeedsLayout();
  }
}
