import 'package:coco_mobile/domain_layer/entities/coco_search_result.dart';

import 'image_model.dart';

class ResultModel extends CocoSearchResult {
  const ResultModel({
    required List<ImageModel> images,
    required int total,
  }) : super(images: images, total: total);

  factory ResultModel.fromJson(
    List<dynamic> imagesJson,
    List<dynamic> segmentationJson,
    List<dynamic> captionsJson, {
    int total = 5,
  }) {
    List<ImageModel> parsedImages = [];

    for (final image in imagesJson) {
      final segmentations = segmentationJson
          .where((element) => element['image_id'] == image['id'])
          .map((e) => ImageSegmentationModel.fromJson(e))
          .toList();

      final captions = captionsJson
          .where((element) => element['image_id'] == image['id'])
          .map((e) => e['caption'].toString())
          .toList();

      parsedImages.add(ImageModel.fromJson(image, segmentations, captions));
    }

    return ResultModel(
      images: parsedImages,
      total: total,
    );
  }

  @override
  List<Object?> get props => [images];
}
