import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/screens/characters_view/characters_views_model.dart';
import 'package:rick_and_morty/widgets/character_card_listview.dart';

class CharactersViews extends StatefulWidget {
  const CharactersViews({super.key});

  @override
  State<CharactersViews> createState() => _CharactersViewsState();
}

class _CharactersViewsState extends State<CharactersViews> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersViewsModel>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty Karakterleri')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SearchInputWidget(), // Arama bileşeni
              Expanded(
                child: Consumer<CharactersViewsModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.characterModel == null ||
                        viewModel.characterModel!.isEmpty) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return CharacterCardListview(
                        characters:
                            viewModel.characterModel, // Doğrudan gönderiyoruz.
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Karakter Ara',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
