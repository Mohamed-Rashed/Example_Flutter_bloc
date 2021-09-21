import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/business_logic/cubit/movies_cubit.dart';
import 'package:movieapp/constants/mycolor.dart';
import 'package:movieapp/data/models/characters.dart';
import 'package:movieapp/presentation/widgets/character_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Character>? allCharacters;
  List<Character>? searchedForCharacters;
  bool _isSearching = false;
  final _searchTextContrllor = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }
  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.kgray,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }
  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allCharacters!.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character:  allCharacters![index],
        );
      },
    );
  }
  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColor.kyellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.kyellow,
        title: Text("Movies",style: TextStyle(
          color: MyColor.kwhite,
        ),),
      ),
      body: buildBlocWidget(),
    );
  }
}
