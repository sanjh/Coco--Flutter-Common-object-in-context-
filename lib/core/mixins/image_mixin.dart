import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDimensions {
  final Size realSize;
  final ImageProvider image;

  ImageDimensions({required this.realSize, required this.image});
}

mixin ImageMeasureMixin {
  Future<ImageDimensions> getImageOriginalSize(String img_url) {
    Completer<ImageDimensions> newcompltr = Completer();
    final imageFromCached = CachedNetworkImageProvider(img_url);

    imageFromCached.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool isCall) {
          var newImg = image.image;
          Size newSize =
              Size(newImg.width.toDouble(), newImg.height.toDouble());
          newcompltr.complete(
            ImageDimensions(image: imageFromCached, realSize: newSize),
          );
        },
      ),
    );
    return newcompltr.future;
  }
}
