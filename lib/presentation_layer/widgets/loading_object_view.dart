import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingObjectView extends StatelessWidget {
  const LoadingObjectView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return const ImageLoadingWidget();
      },
    );
  }
}

class ImageLoadingWidget extends StatelessWidget {
  const ImageLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: Container(
        height: 200,
        color: Colors.white,
        alignment: Alignment.center,
      ),
    );
  }
}
