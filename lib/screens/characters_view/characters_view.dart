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
    final viewModel = context.watch<CharactersViewsModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty Karakterleri')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _searchInputWidget(context, viewModel: viewModel),
              Expanded(
                child:
                    viewModel.characterModel == null ||
                            viewModel.characterModel!.isEmpty
                        ? Align(
                          alignment: Alignment.topCenter,
                          child: const CircularProgressIndicator.adaptive(),
                        )
                        : CharacterCardListview(
                          characters: viewModel.characterModel?.characters,
                          onLoadMore: () => viewModel.getCharactersMore(),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(
    BuildContext context, {
    required CharactersViewsModel viewModel,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: viewModel.getCharactersByName,
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
