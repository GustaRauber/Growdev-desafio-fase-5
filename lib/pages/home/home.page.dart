import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'stores/home.store.dart';
import 'widgets/characters_gridview.widget.dart';
import 'widgets/characters_listview.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeStore = HomeStore();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    homeStore.loadData();
    scrollController.addListener(scrollControllerLoadMore);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollControllerLoadMore() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      homeStore.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Rick and Morty",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Procure pelo seu personagem",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                key: const Key("Filtro"),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefix: const Icon(Icons.search),
                  hintText: ("Nome ou identificador"),
                ),
                onChanged: homeStore.setSearch,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: homeStore.toggleShowInList,
                  icon: Observer(
                    builder: (context) {
                      return Icon(
                        homeStore.showInList ? Icons.grid_view : Icons.list,
                        color: Colors.white,
                        size: 30,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Observer(
                  builder: (_) {
                    return homeStore.showInList
                        ? CharactersListView(
                            homeStore: homeStore,
                            scrollController: scrollController,
                          )
                        : CharactersGridView(
                            homeStore: homeStore,
                            scrollController: scrollController,
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
