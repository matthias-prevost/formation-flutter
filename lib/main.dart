import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project0/widgets/AddToFav.widget.dart';
import 'package:project0/widgets/CocktailDetail.widget.dart';
import 'package:project0/widgets/CocktailList.widget.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:project0/widgets/FavCounter.widget.dart';
import 'package:project0/widgets/Favorites.widget.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:project0/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ProviderScope(child: const App()));
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
            selectedIcon: Stack(
              alignment: Alignment(3, -3),
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                FavCounter()
              ],
            ),
            icon: Stack(
              alignment: Alignment(3, -3),
              children: <Widget>[Icon(Icons.favorite_outline), FavCounter()],
            ),
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
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              context.go("/login");
            },
            icon: Icon(Icons.logout),
          ),
        ],
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
