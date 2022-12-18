// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kandilli_rasathanesi_app/core/helpers/api.dart';
import 'package:kandilli_rasathanesi_app/products/models/earthquake_model.dart';

class EarthquakesViewModel extends ChangeNotifier {
  List<EarthquakeModel> _eartquakes = [];
  List<EarthquakeModel> get eartquakes => _eartquakes;
  List<EarthquakeModel> _searchList = [];
  List<EarthquakeModel> get searchList => _searchList;
  final _api = Api();

  Future<void> getLatestEarthquakes({
    int latestEarthquakesCount = 100,
  }) async {
    String url = "/live.php?limit=$latestEarthquakesCount";
    final result = await _api.dioGet(url: url);

    if (result?.statusCode == HttpStatus.ok) {
      try {
        var datasBest = <EarthquakeModel>[];
        Iterable listBest = result?.data["result"];
        datasBest =
            listBest.map((model) => EarthquakeModel.fromJson(model)).toList();
        _eartquakes = datasBest;
      } catch (e) {
        print(e);
      }
    } else {
      _eartquakes = [];
    }
    notifyListeners();
  }

  void searchEarthquake(String query) {
    if (query.isNotEmpty) {
      final suggestions = eartquakes.where((earthquake) {
        final location = earthquake.lokasyon?.toLowerCase();
        final input = query.toLowerCase();
        return location?.contains(input) ?? false;
      }).toList();
      _searchList = suggestions;
    }
    notifyListeners();
  }
}
