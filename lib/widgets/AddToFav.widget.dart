import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project0/models/favorites.dart';

class AddToFav extends ConsumerWidget {
  const AddToFav({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, ref) {
    if (ref.watch(favoriteNotifier).isFavorite(id)) {
      return IconButton(
          onPressed: () {
            ref.watch(favoriteNotifier).remove(id);
          },
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ));
    }

    return IconButton(
      onPressed: () {
        ref.watch(favoriteNotifier).add(id);
      },
      icon: Icon(Icons.favorite_border),
    );
  }
}
