import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/Models/place_model.dart';
import 'package:provider/provider.dart';

class PlacesProvider with ChangeNotifier {
  List<PlaceModel> _list = [];

  List<PlaceModel> get list {
    return [..._list];
  }

  void addPlace(String newTitle, File newImage) {
    final newPlace = PlaceModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: newTitle,
        coordinates: null,
        address: null,
        image: newImage);
    _list.add(newPlace);
    notifyListeners();
  }
}
