// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kandilli_rasathanesi_app/core/helpers/api.dart';
import 'package:kandilli_rasathanesi_app/products/models/earthquake_model.dart';

class EarthquakesViewModel extends ChangeNotifier {
  List<EarthquakeModel> _earthquakes = [];
  List<EarthquakeModel> get earthquakes => _earthquakes;
  List<EarthquakeModel> _searchList = [];
  List<EarthquakeModel> get searchList => _searchList;
  String _selectedDate = "";
  String get selectedDate => _selectedDate;
  final _api = Api();

  Future<void> getLatestEarthquakes({
    int latestEarthquakesCount = 500,
    String? date,
  }) async {
    String url = date == null
        ? "/live.php?limit=$latestEarthquakesCount"
        : "/index.php?date=$date&limit=$latestEarthquakesCount";
    final result = await _api.dioGet(url: url);

    if (result?.statusCode == HttpStatus.ok) {
      try {
        var datasBest = <EarthquakeModel>[];
        Iterable listBest = result?.data["result"];
        datasBest =
            listBest.map((model) => EarthquakeModel.fromJson(model)).toList();
        _earthquakes = datasBest;
        if (date != null) {
          _earthquakes.sort(
            ((a, b) {
              if (a.dateStamp != null && b.dateStamp != null) {      
                return b.dateStamp!.compareTo(a.dateStamp!);
              } else {
                DateTime now = DateTime.now();
                String nowString = now.toString().substring(0,10);
                return b.dateStamp?.compareTo(a.dateStamp ?? nowString) ?? 1;
              }
            }),
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      _earthquakes = [];
    }
    notifyListeners();
  }

  Future<void> get sortByDate async {
    showDatePicker(
      context: _api.currentContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019, 12, 07),
      lastDate: DateTime.now(),
    ).then((value) async {
      if (value != null) {
        String selectedDate = value.toString();
        _selectedDate = selectedDate.substring(0, 10);
        await getLatestEarthquakes(date: _selectedDate);
      }
      notifyListeners();
    });
  }

  void searchEarthquake(String query) {
    if (query.isNotEmpty) {
      final suggestions = earthquakes.where((earthquake) {
        final location = earthquake.lokasyon?.toLowerCase();
        final input = query.toLowerCase();
        return location?.contains(input) ?? false;
      }).toList();
      _searchList = suggestions;
    }
    notifyListeners();
  }
}
