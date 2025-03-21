import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/widgets/character_cardview.dart';

class CharacterCardListview extends StatefulWidget {
  final List<CharacterModel>? characters; // Nullable list

  const CharacterCardListview({super.key, this.characters}); // const ekledik.

  @override
  State<CharacterCardListview> createState() => _CharacterCardListviewState();
}

class _CharacterCardListviewState extends State<CharacterCardListview> {
  final _scrollController = ScrollController(); // Scroll kontrolcüsü tanımı

  @override
  void initState() {
    super.initState();
    _detectScrollBottom(); // Metodu initState içinde çağırıyoruz.
  }

  void _detectScrollBottom() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentPosition = _scrollController.position.pixels;
      const int delta = 200;

      if (maxScroll - currentPosition <= delta) {
        log("Alta geldiniz"); // Burada eksik noktalı virgül eklendi.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final characterList = widget.characters ?? []; // Null kontrolü ekliyoruz.

    return Flexible(
      child: ListView.builder(
        itemCount: characterList.length, // Boş listede hata önleniyor.
        controller: _scrollController, // Scroll kontrolcüsü eklendi.
        itemBuilder: (context, index) {
          final characterModel = characterList[index];
          return CharacterCardView(
            characterModel: characterModel,
            characters: characterList,
          );
        },
      ),
    );
  }
}
