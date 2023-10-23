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
              final id = state.uri.queryParameters['id'];
              if (id == null) {
                return const Text('Missing parameters');
              }

              return CocktailDetailRoute(id: id);
            },
          )
        ]),
  ],
);
