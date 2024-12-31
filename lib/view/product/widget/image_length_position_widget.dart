import 'package:flutter/material.dart';

class ImageLengthPositonWidget extends StatelessWidget {
  const ImageLengthPositonWidget({
    super.key,
    required this.currentImageIndex,
    required this.images,
  });

  final int currentImageIndex;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '${currentImageIndex + 1} / ${images.length}', 
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}