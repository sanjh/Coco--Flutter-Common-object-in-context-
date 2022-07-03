import 'package:coco_mobile/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search.dart';

class SelectedObject extends StatelessWidget {
  const SelectedObject({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (ctx, provider, child) {
        return Container(
          constraints: const BoxConstraints(
            maxHeight: 120,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Scrollbar(
            trackVisibility: true,
            child: SingleChildScrollView(
              padding: provider.search_objects.isEmpty
                  ? EdgeInsets.zero
                  : const EdgeInsets.all(8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: provider.search_objects
                    .map((e) => Search(object: e))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
