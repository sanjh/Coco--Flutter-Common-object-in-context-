import 'package:coco_mobile/bloc/coco_bloc.dart';
import 'package:coco_mobile/core/mixins/image_mixin.dart';
import 'package:coco_mobile/domain_layer/entities/coco_image.dart';
import 'package:coco_mobile/presentation_layer/widgets/object_paint.dart';
import 'package:coco_mobile/presentation_layer/widgets/loading_object_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultList extends StatelessWidget with ImageMeasureMixin {
  final Function(BuildContext, {int page}) getObjectImages;

  SearchResultList({
    Key? key,
    required this.getObjectImages,
  }) : super(key: key);

  List<CocoImage> _FetchedImages = [];

  final _scrollController = ScrollController();

  bool _isPaginate = true;

  int _pageNo = 1;
  int _totalNo = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CocoBloc, CocoState>(
      builder: (ctx, state) {
        if (state is CocoLoadingState && state.pageNo == 1) {
          _FetchedImages.clear();
          return const LoadingObjectView();
        } else if (state is CocoServerErrorState && state.pageNo == 1) {
          _FetchedImages.clear();
          return Center(child: Text(state.msg));
        } else if (state is CocoNetworkErrorState && state.pageNo == 1) {
          _FetchedImages.clear();
          return Center(child: Text(state.msg));
        } else if (state is CocoResponseState) {
          if (state.pageNo == 1) {
            if (state.response.images.isEmpty) {
              return const Center(child: Text('No Object Found '));
            }

            _FetchedImages = state.response.images;
            _pageNo = 1;
            _totalNo = state.response.total;
            _isPaginate = _FetchedImages.length < _totalNo;
          } else {
            _FetchedImages.addAll(state.response.images);
            _isPaginate = _FetchedImages.length < _totalNo;
          }
        } else {
          if (state.pageNo == 1) _FetchedImages.clear();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_totalNo != 0) const SizedBox(height: 5),
            Expanded(
              child: ListView.separated(
                controller: _scrollController
                  ..addListener(() => _onScrolling(context)),
                itemCount: state is CocoLoadingState ||
                        state is CocoServerErrorState ||
                        state is CocoNetworkErrorState
                    ? _FetchedImages.length + 1
                    : _FetchedImages.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                padding: EdgeInsets.zero,
                itemBuilder: (ctx, index) {
                  if (index == _FetchedImages.length) {
                    final lastItemView = _handlePaginationState(state);
                    if (lastItemView != null) return lastItemView;
                  }

                  return FutureBuilder<ImageDimensions>(
                    future: getImageOriginalSize(_FetchedImages[index].cocoUrl),
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: snapshot.data == null ||
                                        !snapshot.hasData
                                    ? const ImageLoadingWidget()
                                    : CustomPaint(
                                        foregroundPainter: ObjectPaint(
                                          segmentations: _FetchedImages[index]
                                              .segmentations,
                                          originalSize: snapshot.data?.realSize,
                                        ),
                                        child:
                                            Image(image: snapshot.data!.image),
                                      ),
                              ),
                              if (snapshot.data == null || !snapshot.hasData)
                                loader(context),
                              if (snapshot.hasError) errorWidget(),
                            ],
                          ),
                          if (_totalNo == _FetchedImages.length &&
                              index == _FetchedImages.length - 1)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'No more images',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          if (_totalNo == _FetchedImages.length &&
                              index == _FetchedImages.length - 1)
                            const SizedBox(height: 30),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget? _handlePaginationState(CocoState state) {
    if (state is CocoLoadingState) {
      return const ImageLoadingWidget();
    } else if (state is CocoServerErrorState) {
      return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        child: Text(
          state.msg,
          textAlign: TextAlign.center,
        ),
      );
    } else if (state is CocoNetworkErrorState) {
      return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        child: Text(
          state.msg,
          textAlign: TextAlign.center,
        ),
      );
    }

    return null;
  }

  Positioned errorWidget() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Opps somthing went wrong ',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Positioned loader(context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CupertinoActivityIndicator(
                color: Colors.white,
                radius: 15,
              ),
              const SizedBox(height: 10),
              Text(
                'Please wait',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onScrolling(context) {
    final currentExtent = _scrollController.position.pixels;
    final maxExtent = _scrollController.position.maxScrollExtent;

    if (_isPaginate && currentExtent >= maxExtent - 100) {
      _isPaginate = false;

      getObjectImages(context, page: ++_pageNo);
    }
  }
}
