import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class FavoriteStore extends ChangeNotifier {
  var favorites = <WordPair>[];

  void toggleFavorites(current) {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
