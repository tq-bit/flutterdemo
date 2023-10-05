import 'package:flutter/material.dart';
import 'package:namer_app/src/store/favorites.store.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoriteStore = context.watch<FavoriteStore>();

    if (favoriteStore.favorites.isEmpty) {
      return Center(
        child: Text("No favorites yet"),
      );
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text("You have ${favoriteStore.favorites.length} favorites"),
      ),
      for (var pair in favoriteStore.favorites)
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text(pair.asPascalCase),
        )
    ]);
  }
}
