import 'dart:collection';
import 'package:flutter/material.dart';
import './sign.dart';

class SignsModel extends ChangeNotifier {
  final List<Sign> _signs = []; // TODO not dynamic

  UnmodifiableListView<Sign> get signs => UnmodifiableListView(_signs);

  void update(List<Sign> signs) {
    _signs.clear();
    // TODO where to prepare data?
    // final preparedSignsList = signs.map((signJSON) => Sign.fromJSON(signJSON));
    _signs.addAll(signs);
    notifyListeners();
  }
}
