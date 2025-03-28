import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/models/location_model.dart';
import 'package:rick_and_morty/screens/residents_view/resident_viewmodel.dart';
import 'package:rick_and_morty/widgets/appvar_widget.dart';
import 'package:rick_and_morty/widgets/character_card_listview.dart';

class ResidentsView extends StatefulWidget {
  final LocationItem locationItem;
  const ResidentsView({super.key, required this.locationItem});

  @override
  State<ResidentsView> createState() => _ResidentsViewState();
}

class _ResidentsViewState extends State<ResidentsView> {
  @override
  void initState() {
    super.initState();
    context.read<ResidentViewmodel>().getResidents(
      widget.locationItem.residents,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.locationItem.name),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Consumer<ResidentViewmodel>(
              builder: (context, viewModel, child) {
                return CharacterCardListView(characters: viewModel.residents);
              },
            ),
          ],
        ),
      ),
    );
  }
}
