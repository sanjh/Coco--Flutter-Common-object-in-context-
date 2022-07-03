import 'package:coco_mobile/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  final String object;

  const Search({Key? key, required this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<SearchProvider>(context, listen: false)
            .removeObject(object);
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.8),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              object,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.black),
            ),
          ),
          const Positioned(
              right: 0,
              top: 0,
              child: Icon(
                Icons.cancel,
                size: 15,
              ))
        ],
      ),
    );
  }
}
