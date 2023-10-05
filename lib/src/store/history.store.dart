import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class HistoryStore extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}
