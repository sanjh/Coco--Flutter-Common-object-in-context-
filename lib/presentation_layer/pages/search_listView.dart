import 'package:cached_network_image/cached_network_image.dart';
import 'package:coco_mobile/core/consts/const_api.dart';
import 'package:coco_mobile/core/consts/const_objects.dart';
import 'package:flutter/material.dart';

class SearchListView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      hintColor: Colors.white,
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          ),
      appBarTheme:
          Theme.of(context).appBarTheme.copyWith(backgroundColor: Colors.black),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: InputBorder.none,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final categories = objectsMap.keys.toList();

    final searchResult = categories
        .where((element) => element.contains(query) || query.contains(element))
        .toList();

    return ListView.separated(
      itemCount: searchResult.length,
      itemBuilder: (ctx, index) {
        return ListTile(
          leading: SizedBox(
            width: 40,
            child: CachedNetworkImage(
              imageUrl:
                  '${ApiEndpoints.fixedImagesUrl}${objectsMap[searchResult[index]]}.jpg',
              height: 40,
            ),
          ),
          title: Text(searchResult[index]),
          onTap: () {
            Navigator.of(context).pop(searchResult[index]);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
