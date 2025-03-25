import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/models/characters_model.dart';

class CharacterCardView extends StatelessWidget {
  final CharacterModel characterModel;
  const CharacterCardView({super.key, required this.characterModel, required characters, required bool isFavorited});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    characterModel.image ?? '',
                    height: 110,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 17,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        characterModel.name ?? 'Unknown',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      infoWidget(
                        type: "Köken",
                        value: characterModel.origin.name ?? 'Unknown',
                      ),
                      const SizedBox(height: 4),
                      infoWidget(
                        type: "Durum",
                        value:
                            "${characterModel.status ?? 'Unknown'} - ${characterModel.species ?? 'Unknown'}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
        ],
      ),
    );
  }

  Column infoWidget({required String type, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
