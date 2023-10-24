import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project0/router.dart';
import 'package:project0/widgets/AddToFav.widget.dart';
import 'package:project0/widgets/CocktailDetail.widget.dart';
import 'package:project0/widgets/CocktailList.widget.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:project0/widgets/Favorites.widget.dart';

void main() {
  runApp(ProviderScope(child: const NavigationBarApp()));
}

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        CocktailHome(title: "Cocktails"),
        Favorites(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.inversePrimary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.deepPurple,
            ),
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            icon: Icon(Icons.favorite_outline),
            label: 'Favoris',
          ),
        ],
      ),
    );
  }
}

class CocktailHome extends StatelessWidget {
  const CocktailHome({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(child: CocktailList()),
    );
  }
}

class CocktailDetailRoute extends StatelessWidget {
  const CocktailDetailRoute({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Détails du cocktail"),
          actions: [AddToFav(id: id)]),
      body: SingleChildScrollView(
        child: Center(
            child: CocktailDetail(
          id: id,
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/'),
        child: Text("Retour"),
      ),
    );
  }
}
