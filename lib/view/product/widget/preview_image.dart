import 'dart:convert';

import 'package:flutter/material.dart';

class FullScreenImagePreview extends StatelessWidget {
  final List<String> images;

  const FullScreenImagePreview({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Preview")),
      body: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Center(
            child: Image.memory(
              base64Decode(images[index]),
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}