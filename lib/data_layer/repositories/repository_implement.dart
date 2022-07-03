import 'package:coco_mobile/core/errors/failures.dart';
import 'package:coco_mobile/core/errors/network_error.dart';
import 'package:coco_mobile/core/errors/server_error.dart';
import 'package:coco_mobile/domain_layer/entities/coco_search_result.dart';
import 'package:coco_mobile/domain_layer/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import '../datasources/datasource.dart';

class RepositoryImplement implements SearchRepository {
  final CocoDataSource remoteDataSource;

  RepositoryImplement({required this.remoteDataSource});

  @override
  Future<Either<Failure, CocoSearchResult>> searchCOCODataset(
    List<int> objectIds, {
    int page = 1,
  }) async {
    try {
      final res =
          await remoteDataSource.searchCocoDataset(objectIds, page: page);

      return Right(res);
    } on ServerError catch (e) {
      return Left(ServerFailure(msg: e.msg));
    } on NetworkEroor catch (e) {
      return Left(ServerFailure(msg: e.msg));
    }
  }
}
