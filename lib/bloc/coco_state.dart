part of 'coco_bloc.dart';

abstract class CocoState extends Equatable {
  final int pageNo;
  const CocoState({this.pageNo = 1});

  @override
  List<Object?> get props => [pageNo];
}

class CocoInitial extends CocoState {
  const CocoInitial({int pageNo = 1}) : super(pageNo: pageNo);
}

class CocoLoadingState extends CocoState {
  const CocoLoadingState({int pageNo = 1}) : super(pageNo: pageNo);
}

class CocoServerErrorState extends CocoState {
  final String msg;

  const CocoServerErrorState({required this.msg, int pageNo = 1})
      : super(pageNo: pageNo);

  @override
  List<Object?> get props => [msg];
}

class CocoNetworkErrorState extends CocoState {
  final String msg;

  const CocoNetworkErrorState({required this.msg, int pageNo = 1})
      : super(pageNo: pageNo);

  @override
  List<Object?> get props => [msg];
}

class CocoResponseState extends CocoState {
  final CocoSearchResult response;

  const CocoResponseState({required this.response, int pageNo = 1})
      : super(pageNo: pageNo);

  @override
  List<Object?> get props => [response];
}
