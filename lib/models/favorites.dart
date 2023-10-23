import 'package:flutter/foundation.dart';

class FavoritesModel extends ChangeNotifier {
  final List<String> _itemIds = [];

  int get numberOfFavorites => _itemIds.length;

  void add(String id) {
    if (_itemIds.contains(id)) {
      _itemIds.add(id);
      notifyListeners();
    }
  }

  void remove(String id) {
    _itemIds.remove(id);
    notifyListeners();
  }
}
