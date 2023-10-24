import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project0/infra/cocktails.dart';
import 'package:project0/models/favorites.dart';
import 'package:project0/widgets/ListItem.widget.dart';

class Favorites extends ConsumerStatefulWidget {
  const Favorites({super.key});

  @override
  FavoritesState createState() => FavoritesState();
}

class FavoritesState extends ConsumerState<Favorites> {
  late Future<List<Cocktail>> favorites;

  @override
  void initState() {
    super.initState();
    favorites = getFavorites(ref.read(favoriteNotifier).itemIds);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(favoriteNotifier, (previous, next) {
      setState(() {
        favorites = getFavorites(next.itemIds);
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: const Text('Favoris'),
      ),
      body: FutureBuilder(
        future: favorites,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(child: Text('Aucun favoris'));
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Cocktail cocktail = snapshot.data![index];
                  return ListItem(
                      id: cocktail.id,
                      name: cocktail.name,
                      imageURL: cocktail.imageURL);
                });
          }

          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
