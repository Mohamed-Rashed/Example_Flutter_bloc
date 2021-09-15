import 'package:flutter/material.dart';
import 'package:movieapp/app_router.dart';

void main() {
  runApp(MoviesApp(appRouter: AppRouter(),));
}

class MoviesApp extends StatelessWidget {
  final AppRouter appRouter;

  MoviesApp({required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.genrateRoute,
    );
  }
}

