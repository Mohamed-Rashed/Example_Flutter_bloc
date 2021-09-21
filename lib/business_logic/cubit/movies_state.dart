part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class CharactersLoaded extends MoviesState{
  final List<Character> characters;

  CharactersLoaded(this.characters);
}
