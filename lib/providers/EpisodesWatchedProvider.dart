// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class EpisodesWatchedProvider with ChangeNotifier {
  List<String> eps = [];
  final String slug;
  SharedPreferences pref;

  EpisodesWatchedProvider({@required this.slug}) {
    getWatchedPref();
  }

  void addWatched(int ep) {
    eps.add(ep.toString());
  }

  void removeWatched(int ep) {
    eps.remove(ep.toString());
  }

  bool isWatched(int ep) {
    return eps.contains(ep.toString());
  }

  Future getWatchedPref() async {
    pref = await SharedPreferences.getInstance();
    eps = pref.getStringList(slug) ?? [];
  }

  Future toggleWatched(int id) async {
    eps.contains(id.toString()) ? removeWatched(id) : addWatched(id);
    await setWatchedPref();
    notifyListeners();
  }

  Future setWatchedPref() async {
    pref.setStringList(slug, eps);
  }
}