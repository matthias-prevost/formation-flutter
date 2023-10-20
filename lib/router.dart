import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project0/main.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => MyHomePage(title: 'La BDD des cocktails'),
        routes: [
          GoRoute(
            path: 'cocktail',
            builder: (context, state) {
              final name = state.uri.queryParameters['name'];
              final instructions = state.uri.queryParameters['instructions'];
              final imageURL = state.uri.queryParameters['imageURL'];
              if (name == null || instructions == null || imageURL == null) {
                return const Text('Missing parameters');
              }

              return CocktailDetailRoute(
                  name: name, instructions: instructions, imageURL: imageURL);
            },
          )
        ]),
  ],
);
