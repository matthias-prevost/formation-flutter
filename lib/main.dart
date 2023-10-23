import 'package:project0/models/Favorites.dart';
import 'package:project0/router.dart';
import 'package:project0/widgets/AddToFav.widget.dart';
import 'package:project0/widgets/CocktailDetail.widget.dart';
import 'package:project0/widgets/CocktailList.widget.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => FavoritesModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

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
