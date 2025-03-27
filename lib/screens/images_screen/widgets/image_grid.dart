import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_placeholder_cache_image/entity/image_entity.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({required this.images, super.key});

  final List<ImageEntity> images;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.file(File(images[index].path), fit: BoxFit.cover),
        );
      },
    );
  }
}
