import 'package:flutter/material.dart';

class ImageOverlayWidget extends StatelessWidget {
  final ImageProvider image;
  final AlignmentGeometry alignment;
  final Widget child;
  final BoxFit? fit;
  final double? opacity;

  const ImageOverlayWidget({
    super.key,
    required this.image,
    required this.alignment,
    required this.child,
    this.fit,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          alignment: alignment,
          fit: fit,
          opacity: opacity ?? 1.0,
        ),
      ),
      child: child,
    );
  }
}
