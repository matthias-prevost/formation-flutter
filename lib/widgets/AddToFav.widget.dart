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
        if (favorites.isFavorite(widget.id)) {
          return IconButton(
              onPressed: () {
                favorites.remove(widget.id);
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ));
        }

        return IconButton(
          onPressed: () {
            favorites.add(widget.id);
          },
          icon: Icon(Icons.favorite_border),
        );
      },
    );
  }
}
