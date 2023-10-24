import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends ChangeNotifier {
  final List<String> _itemIds = [];

  int get numberOfFavorites => _itemIds.length;
  List<String> get itemIds => _itemIds;

  bool isFavorite(String id) {
    return _itemIds.contains(id);
  }

  void add(String id) {
    if (!_itemIds.contains(id)) {
      _itemIds.add(id);
      notifyListeners();
    }
  }

  void remove(String id) {
    _itemIds.remove(id);
    notifyListeners();
  }
}

final favoriteNotifier = ChangeNotifierProvider<FavoritesNotifier>((ref) {
  return FavoritesNotifier();
});
