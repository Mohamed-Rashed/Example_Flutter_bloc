import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/data/models/characters.dart';
import 'package:movieapp/data/repository/character_repo.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {

  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  MoviesCubit(this.charactersRepository) : super(MoviesInitial());

  List<Character> getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters){
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
