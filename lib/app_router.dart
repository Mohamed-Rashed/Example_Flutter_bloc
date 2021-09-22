import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/business_logic/cubit/movies_cubit.dart';
import 'package:movieapp/constants/strings.dart';
import 'package:movieapp/data/models/characters.dart';
import 'package:movieapp/data/repository/character_repo.dart';
import 'package:movieapp/data/web_services/character_web_services.dart';
import 'package:movieapp/presentation/screens/home_screen.dart';
import 'package:movieapp/presentation/screens/movie_details.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late MoviesCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = MoviesCubit(charactersRepository);
  }

  Route? genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MoviesCubit(charactersRepository),
                  child: HomeScreen(),
                ));
      case movieDetailsRoute:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MoviesCubit(charactersRepository),
                  child: CharacterDetailsScreen(character: character),
                ));
    }
  }
}
