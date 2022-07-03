import 'package:bloc/bloc.dart';
import 'package:coco_mobile/core/errors/failures.dart';
import 'package:coco_mobile/domain_layer/entities/coco_search_result.dart';
import 'package:coco_mobile/domain_layer/other_cases/search_coco_dataset.dart';
import 'package:equatable/equatable.dart';
part 'coco_event.dart';
part 'coco_state.dart';

class CocoBloc extends Bloc<CocoEvent, CocoState> {
  final SearchCocoDataset searchCocoDataset;

  CocoBloc({required this.searchCocoDataset}) : super(const CocoInitial()) {
    on<SearchCocoDatasetEvent>((event, emit) async {
      emit(CocoLoadingState(pageNo: event.page));

      final resultEither = await searchCocoDataset(
        SearchParams(categoryIds: event.categoryIds, page: event.page),
      );

      resultEither.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(CocoServerErrorState(
              msg: failure.msg,
              pageNo: event.page,
            ));
          } else if (failure is NetworkFailure) {
            emit(CocoNetworkErrorState(
              msg: failure.msg,
              pageNo: event.page,
            ));
          } else {
            emit(CocoServerErrorState(
              msg: failure.msg,
              pageNo: event.page,
            ));
          }
        },
        (result) {
          emit(CocoResponseState(
            response: result,
            pageNo: event.page,
          ));
        },
      );
    });
  }
}
