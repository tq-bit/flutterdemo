import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/src/store/history.store.dart';
import 'package:namer_app/src/store/favorites.store.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoriteStore = context.watch<FavoriteStore>();
    var historyStore = context.watch<HistoryStore>();
    var pair = historyStore.current;
    IconData icon;
    String buttonText;
    favoriteStore.favorites.contains(historyStore.current)
        ? icon = Icons.favorite
        : icon = Icons.favorite_border;
    favoriteStore.favorites.contains(historyStore.current)
        ? buttonText = "Liked"
        : buttonText = "Like";

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () =>
                    favoriteStore.toggleFavorites(historyStore.current),
                child: Row(
                  children: [
                    Icon(icon),
                    SizedBox(width: 4.0),
                    Text(buttonText),
                  ],
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => {historyStore.getNext()},
                child: Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var styleFirst = theme.textTheme.displaySmall!
        .copyWith(color: theme.colorScheme.onPrimary);
    var styleSecond = theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pair.first,
              style: styleFirst,
              semanticsLabel: pair.first,
            ),
            Text(
              pair.second,
              style: styleSecond,
              semanticsLabel: pair.second,
            )
          ],
        ),
      ),
    );
  }
}
