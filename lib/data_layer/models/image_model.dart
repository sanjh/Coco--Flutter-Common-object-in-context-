import 'dart:convert';

import 'package:coco_mobile/domain_layer/entities/coco_image.dart';
import 'package:flutter/material.dart';

class ImageModel extends CocoImage {
  const ImageModel({
    required int id,
    required String cocoUrl,
    required String flickrUrl,
    required List<String> captions,
    required List<ImageSegmentationModel> segmentations,
  }) : super(
          id: id,
          cocoUrl: cocoUrl,
          flickrUrl: flickrUrl,
          captions: captions,
          segmentations: segmentations,
        );

  factory ImageModel.fromJson(
    Map<String, dynamic> imagesJson,
    List<ImageSegmentationModel> segmentations,
    List<String> captions,
  ) {
    return ImageModel(
      id: imagesJson['id'],
      cocoUrl: imagesJson['coco_url'],
      flickrUrl: imagesJson['flickr_url'],
      captions: captions,
      segmentations: segmentations,
    );
  }
}

class ImageSegmentationModel extends ImageSegmentation {
  const ImageSegmentationModel({
    required int categoryId,
    required List<num> points,
  }) : super(categoryId: categoryId, points: points);

  factory ImageSegmentationModel.fromJson(Map<String, dynamic> parsedJson) {
    debugPrint(parsedJson['segmentation']);

    return ImageSegmentationModel(
      categoryId: parsedJson['category_id'],
      points: json.decode(parsedJson['segmentation'] ?? "[[]]") is List
          ? List<num>.from(
              (json.decode(parsedJson['segmentation'] ?? "[[]]")
                      as List<dynamic>)
                  .first,
            )
          : List<num>.from(
              json.decode(
                  parsedJson['segmentation'] ?? "{counts: []}")['counts'],
            ),
    );
  }
}
