import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project0/models/Favorites.dart';

class AddToFav extends ConsumerWidget {
  const AddToFav({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, ref) {
    if (ref.watch(myNotifierProvider).isFavorite(id)) {
      return IconButton(
          onPressed: () {
            ref.watch(myNotifierProvider).remove(id);
          },
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ));
    }

    return IconButton(
      onPressed: () {
        ref.watch(myNotifierProvider).add(id);
      },
      icon: Icon(Icons.favorite_border),
    );
  }
}
