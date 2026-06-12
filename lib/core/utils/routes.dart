import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_reader_app/features/auth/presentation/screens/login_screen.dart';
import 'package:news_reader_app/features/bookmarks/presentation/screens/bookmark_screen.dart';
import 'package:news_reader_app/features/home/presentation/screens/home_screen.dart';


GoRouter createRouter(bool isLoggedIn){
  return GoRouter(
    initialLocation: isLoggedIn ? '/home' : '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen()
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeSCreen()
      ),
      GoRoute(
        path: '/bookmark',
        builder: (context, state) => const BookMarkScreen()
      )
    ]
  );
}