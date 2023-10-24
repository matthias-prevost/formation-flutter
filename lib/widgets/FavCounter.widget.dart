import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project0/models/Favorites.dart';

class FavCounter extends ConsumerStatefulWidget {
  const FavCounter({super.key});

  @override
  FavCounterState createState() => FavCounterState();
}

class FavCounterState extends ConsumerState<FavCounter> {
  late int favCount;

  @override
  void initState() {
    super.initState();
    favCount = ref.read(favoriteNotifier).numberOfFavorites;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(favoriteNotifier, (previous, next) {
      setState(() {
        favCount = next.numberOfFavorites;
      });
    });

    if (favCount == 0) {
      return const SizedBox.shrink();
    }
    return Badge(textColor: Colors.white, label: Text("$favCount"));
  }
}
