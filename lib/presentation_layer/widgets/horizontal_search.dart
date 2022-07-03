import 'package:cached_network_image/cached_network_image.dart';
import 'package:coco_mobile/core/consts/const_api.dart';
import 'package:coco_mobile/core/consts/const_objects.dart';
import 'package:coco_mobile/provider/search_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class horizontalSearch extends StatefulWidget {
  horizontalSearch({Key? key}) : super(key: key);

  @override
  State<horizontalSearch> createState() => _horizontalSearchState();
}

class _horizontalSearchState extends State<horizontalSearch> {
  Widget buildSuggestions(BuildContext context) {
    final categories = objectsMap.keys.toList();

    // final searchResult = categories
    //     .where((element) => element.contains(query) || query.contains(element))
    //     .toList();

    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2 / 2,
        crossAxisCount: 2,
      ),
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            // Navigator.of(context).pop(categories[index]);

            Provider.of<SearchProvider>(context, listen: false)
                .addNewObject(categories[index]);
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: SizedBox(
              width: 40,
              child: CachedNetworkImage(
                imageUrl:
                    '${ApiEndpoints.fixedImagesUrl}${objectsMap[categories[index]]}.jpg',
                height: 40,
              ),
            ),
          ),
        );
        // return ListTile(
        //   leading: SizedBox(
        //     width: 40,
        //     child: CachedNetworkImage(
        //       imageUrl:
        //           '${ApiEndpoints.imagesBaseUrl}${categoryToId[categories[index]]}.jpg',
        //       height: 40,
        //     ),
        //   ),
        //   title: Text(categories[index]),
        //   onTap: () {
        //     Navigator.of(context).pop(categories[index]);
        //   },
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSuggestions(context);
  }
}
// class horizontalSearch extends StatelessWidget {
//   const horizontalSearch({Key? key}) : super(key: key);

//   Widget buildSuggestions(BuildContext context) {
//     final categories = categoryToId.keys.toList();

//     // final searchResult = categories
//     //     .where((element) => element.contains(query) || query.contains(element))
//     //     .toList();

//     return ListView.builder(
//       shrinkWrap: true,
//       scrollDirection: Axis.horizontal,
//       itemCount: categories.length,
//       itemBuilder: (ctx, index) {
//         return ListTile(
//           leading: SizedBox(
//             width: 40,
//             child: CachedNetworkImage(
//               imageUrl:
//                   '${ApiEndpoints.imagesBaseUrl}${categoryToId[categories[index]]}.jpg',
//               height: 40,
//             ),
//           ),
//           title: Text(categories[index]),
//           onTap: () {
//             Navigator.of(context).pop(categories[index]);
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return buildSuggestions(context);
//   }
// }
