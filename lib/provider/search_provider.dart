import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  final List<String> _search_objects = [];

  void addNewObject(String object) {
    if (!_search_objects.contains(object)) {
      _search_objects.add(object);
      notifyListeners();
    }
  }

  void removeObject(String object) {
    if (_search_objects.contains(object)) {
      _search_objects.remove(object);
      notifyListeners();
    }
  }

  List<String> get search_objects => [..._search_objects];
}
