import 'package:coco_mobile/core/errors/failures.dart';
import 'package:coco_mobile/core/network/network.dart';

import 'package:coco_mobile/domain_layer/entities/coco_search_result.dart';
import 'package:coco_mobile/domain_layer/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SearchCocoDataset extends UseCase<CocoSearchResult, SearchParams> {
  final SearchRepository repository;

  SearchCocoDataset({required this.repository});

  @override
  Future<Either<Failure, CocoSearchResult>> call(SearchParams params) {
    return repository.searchCOCODataset(params.categoryIds, page: params.page);
  }
}

class SearchParams extends Equatable {
  final List<int> categoryIds;
  final int page;

  const SearchParams({required this.categoryIds, this.page = 1});

  @override
  List<Object?> get props => [categoryIds, page];
}
