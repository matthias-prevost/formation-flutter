import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project0/main.dart';
import 'package:project0/view/login.dart';

final router = GoRouter(
  redirect: (context, state) {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      return null;
    }

    return '/login';
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => NavigationExample(),
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
      ],
    ),
    GoRoute(path: "/login", builder: (context, state) => Login())
  ],
);
