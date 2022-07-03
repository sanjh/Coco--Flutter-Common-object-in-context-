import 'package:coco_mobile/core/api/api_handling.dart';
import 'package:coco_mobile/core/consts/const_api.dart';
import 'package:coco_mobile/core/errors/network_error.dart';
import 'package:coco_mobile/core/network/network.dart';

import '../models/result_model.dart';

abstract class CocoDataSource {
  Future<ResultModel> searchCocoDataset(
    List<int> objectId, {
    int page = 1,
  });
}

class SearchDataSourceImplement implements CocoDataSource {
  final ApiBasic apiHandler;
  final Network networkInfo;

  SearchDataSourceImplement({
    required this.apiHandler,
    required this.networkInfo,
  });

  List<int> _getImagesIds = [];

  @override
  Future<ResultModel> searchCocoDataset(
    List<int> objectIds, {
    int page = 1,
  }) async {
    if (await networkInfo.isInternet) {
      List<int> fetchedImages = [];

      if (page == 1) {
        final imagesIdsJson = await _getImagesByObject(objectIds) ?? [];

        _getImagesIds = List<int>.from(imagesIdsJson as List<dynamic>);
        if (_getImagesIds.length >= 5) {
          fetchedImages = _getImagesIds.sublist(0, 5);
        } else {
          fetchedImages = _getImagesIds;
        }
      } else {
        if (_getImagesIds.length >= page * 5) {
          fetchedImages = _getImagesIds.sublist((page - 1) * 5, page * 5);
        } else {
          fetchedImages = _getImagesIds.sublist(
            (page - 1) * 5,
            _getImagesIds.length,
          );
        }
      }

      late List result = [[], [], []];

      if (fetchedImages.isNotEmpty) {
        result = await Future.wait([
          _getImageProperties(fetchedImages),
          _getSegmentations(fetchedImages),
          _getCaptions(fetchedImages),
        ]);
      }

      return ResultModel.fromJson(
        result[0],
        result[1],
        result[1],
        total: _getImagesIds.length,
      );
    } else {
      throw NetworkEroor(
        msg: 'please check your internet connectionand try again.',
      );
    }
  }

  Future _getImagesByObject(List<int> objectId) {
    return apiHandler.post(
      ApiEndpoints.cocoUrl,
      body: {"category_ids": objectId, "querytype": "getImagesByCats"},
    );
  }

  Future _getImageProperties(List<int> imagesIds) {
    return apiHandler.post(
      ApiEndpoints.cocoUrl,
      body: {"image_ids": imagesIds, "querytype": "getImages"},
    );
  }

  Future _getSegmentations(List<int> imagesIds) {
    return apiHandler.post(
      ApiEndpoints.cocoUrl,
      body: {"image_ids": imagesIds, "querytype": "getInstances"},
    );
  }

  Future _getCaptions(List<int> imagesIds) {
    return apiHandler.post(
      ApiEndpoints.cocoUrl,
      body: {"image_ids": imagesIds, "querytype": "getCaptions"},
    );
  }
}
