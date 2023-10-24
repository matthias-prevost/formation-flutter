import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project0/infra/cocktails.dart';
import 'package:project0/models/Favorites.dart';

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
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 16.0, right: 16.0, top: 8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(0)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)))),
                        onPressed: () {
                          context.go(Uri(path: '/cocktail', queryParameters: {
                            'id': cocktail.id,
                          }).toString());
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(cocktail.name),
                          leading: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0)),
                              child: Image.network(
                                cocktail.imageURL,
                              )),
                        )),
                  );
                });
          }

          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
