import 'package:flutter/material.dart';
import 'package:project0/models/Favorites.dart';
import 'package:provider/provider.dart';

class AddToFav extends StatefulWidget {
  const AddToFav({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _AddToFavState createState() => _AddToFavState();
}

class _AddToFavState extends State<AddToFav> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesModel>(
      builder: (context, favorites, child) {
        return IconButton(
          onPressed: () {
            if (favorites.isFavorite(widget.id))
              favorites.remove(widget.id);
            else {
              favorites.add(widget.id);
            }
          },
          icon: favorites.isFavorite(widget.id)
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
        );
      },
    );
  }
}
