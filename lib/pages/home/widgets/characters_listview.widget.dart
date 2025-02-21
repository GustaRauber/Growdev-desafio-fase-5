import 'package:fase_5/pages/home/detail/detail.page.dart';
import 'package:fase_5/pages/home/stores/home.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'character_card_listview.widget.dart';

class CharactersListView extends StatelessWidget {
  final HomeStore _homeStore;
  final ScrollController _scrollController;

  const CharactersListView({
    super.key,
    required HomeStore homeStore,
    required ScrollController scrollController,
  })  : _homeStore = homeStore,
        _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListView.builder(
          key: const Key("listView"),
          controller: _scrollController,
          itemCount: _homeStore.filteredCharacters.length + 1,
          itemBuilder: (context, index) {
            if (index < _homeStore.filteredCharacters.length) {
              final character = _homeStore.filteredCharacters[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailPage(
                        character: character,
                      ),
                    ),
                  );
                },
                child: CharacterListView(
                  character: character,
                  homeStore: _homeStore,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
