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

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextContrllor,
      cursorColor: MyColor.kgray,
      decoration: InputDecoration(
        hintText: "Find Character",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColor.kgray,
          fontSize: 18,
        ),
      ),
      style: TextStyle(fontSize: 18, color: MyColor.kgray),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters!
        .where((Character) =>
            Character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColor.kgray),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: MyColor.kgray,
          ),
        ),
      ];
    }
  }

  void _clearSearch() {
    setState(() {
      _searchTextContrllor.clear();
    });
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColor.kwhite),
    );
  }

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
    return _searchTextContrllor.text.isNotEmpty &&
            searchedForCharacters!.length == 0
        ? Column(
            children: [
              Image.asset('assets/images/sorry.gif'),
              Text(
                "sorry no results found :(",
                style: TextStyle(color: MyColor.kwhite, fontSize: 18),
              )
            ],
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: _searchTextContrllor.text.isEmpty
                ? allCharacters!.length
                : searchedForCharacters!.length,
            itemBuilder: (ctx, index) {
              return CharacterItem(
                character: _searchTextContrllor.text.isEmpty
                    ? allCharacters![index]
                    : searchedForCharacters![index],
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
      backgroundColor: MyColor.kgray,
      appBar: AppBar(
        backgroundColor: MyColor.kyellow,
        leading: _isSearching
            ? BackButton(
                color: MyColor.kgray,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
