import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/widgets/character_cardview.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/services/preferences_service.dart';

class CharacterCardListview extends StatefulWidget {
  final List<CharacterModel>? characters; // Karakter listesi nullable
  final VoidCallback? onLoadMore; // Listeyi genişletme
  final bool loadMore; // Daha fazla yükleme durumu

  const CharacterCardListview({
    super.key,
    this.characters,
    this.onLoadMore,
    this.loadMore = false,
  });

  @override
  State<CharacterCardListview> createState() => _CharacterCardListviewState();
}

class _CharacterCardListviewState extends State<CharacterCardListview> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false; // İlk başta yükleme durumu false
  List<int> _favoritedList = [];

  @override
  void initState() {
    super.initState();
    _getFavorites();
    _detectScrollBottom(); // Scroll tabanı algılama
  }

  // ignore: unused_element
  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  Future<void> _getFavorites() async {
    // Kaydedilen favorileri al
    _favoritedList = locator<PreferencesService>().getSavedCharacters();
    setState(() {
      _isLoading = false; // Yükleme bittiğinde _isLoading false olacak
    });
  }

  void _detectScrollBottom() {
    if (widget.onLoadMore != null) {
      _scrollController.addListener(() {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentPosition = _scrollController.position.pixels;
        const int delta = 200;

        // Eğer kullanıcı aşağı kaydırdığında yeni veriler yükleniyorsa
        if (maxScroll - currentPosition <= delta) {
          widget.onLoadMore!(); // Yükleme fonksiyonunu çağır
          setState(() {
            _isLoading =
                true; // Yeni karakterler yükleniyor, bu yüzden yükleme durumunu true yapıyoruz
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final characterList = widget.characters ?? [];

    return Flexible(
      child: ListView.builder(
        itemCount:
            characterList.length +
            (_isLoading ? 1 : 0), // Yükleme göstergesi ekle
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (index == characterList.length && _isLoading) {
            // Yükleme göstergesi sadece son karakterin altında ekleniyor
            return Center(
              child: SizedBox(
                width: 50, // Boyutu küçültme
                height: 50, // Boyutu küçültme
                child: const CircularProgressIndicator(),
              ),
            );
          }

          final characterModel = characterList[index];
          final bool isFavorited = _favoritedList.contains(characterModel.id);

          return Column(
            children: [
              CharacterCardView(
                isFavorited: isFavorited,
                characterModel: characterModel,
                characters: null,
              ),
            ],
          );
        },
      ),
    );
  }
}
