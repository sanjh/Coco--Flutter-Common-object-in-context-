import 'dart:developer' as dev;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coco_mobile/bloc/coco_bloc.dart';
import 'package:coco_mobile/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/consts/const_objects.dart';

import 'search_listView.dart';

import '../widgets/horizontal_search.dart';
import '../widgets/search_result_list.dart';
import '../widgets/selected_object.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).padding.top + 8),
            SizedBox(
              height: 80,
              child: horizontalSearch(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _searchWidget(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: const [
                              Icon(Icons.search),
                              Text('search an object..'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SelectedObject(),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextButton(
                onPressed: () => _getObjectsImages(context),
                child: const Text('Search'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SearchResultList(getObjectImages: _getObjectsImages),
            ),
          ],
        ),
      ),
    );
  }

  void _getObjectsImages(BuildContext context, {int page = 1}) {
    FocusScope.of(context).unfocus();

    final objects =
        Provider.of<SearchProvider>(context, listen: false).search_objects;

    late List<int> objetcIds;

    if (objects.isNotEmpty) {
      objetcIds = objectsMap.entries
          .where((element) => objects.contains(element.key))
          .map((e) => e.value)
          .toList();
    } else {
      objetcIds = [-1];
    }

    BlocProvider.of<CocoBloc>(context).add(
      SearchCocoDatasetEvent(categoryIds: objetcIds, page: page),
    );
  }

  void _searchWidget(context) async {
    final object = await showSearch(
      context: context,
      delegate: SearchListView(),
    );

    if (object != null && object is String) {
      Provider.of<SearchProvider>(context, listen: false).addNewObject(object);
    }
  }
}
