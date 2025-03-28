import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/screens/characters_view/characters_views_model.dart';
import 'package:rick_and_morty/widgets/appvar_widget.dart';
import 'package:rick_and_morty/widgets/character_card_listview.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();

    // Widget ağacı yüklendikten sonra ViewModel'den karakterleri getir
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharactersViewmodel>().getCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharactersViewmodel>(); // ViewModel'i izle

    return Scaffold(
      appBar: const AppBarWidget(title: 'Rick and Morty'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              _searchInputWidget(context, viewModel: viewModel),
              viewModel.charactersModel == null
                  ? const CircularProgressIndicator.adaptive() // Yükleniyor animasyonu
                  : CharacterCardListView(
                    characters: viewModel.charactersModel!.characters,
                    onLoadMore: () => viewModel.getCharactersMore(),
                    loadMore: viewModel.loadMore,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(
    BuildContext context, {
    required CharactersViewmodel viewModel,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: viewModel.getCharactersByName,
        decoration: InputDecoration(
          hintText: 'Karakterlerde Ara',
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: viewModel.onCharacterTypeChanged,
            itemBuilder: (context) {
              return CharacterType.values
                  .map(
                    (e) => PopupMenuItem<CharacterType>(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList();
            },
          ),
        ),
      ),
    );
  }
}
