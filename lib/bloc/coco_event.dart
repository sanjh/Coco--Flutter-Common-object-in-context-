part of 'coco_bloc.dart';

abstract class CocoEvent extends Equatable {
  const CocoEvent();
}

class SearchCocoDatasetEvent extends CocoEvent {
  final List<int> categoryIds;
  final int page;

  const SearchCocoDatasetEvent({required this.categoryIds, this.page = 1});

  @override
  List<Object?> get props => [categoryIds, page];
}
