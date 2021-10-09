import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/Helpers/db_helper.dart';
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
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetProducts() async {
    final data = await DBHelper.getData('user_places');
    _list = data
        .map((model) => PlaceModel(
            id: model['id'],
            title: model['title'],
            coordinates: null,
            address: null,
            image: File(model['image'])))
        .toList();
    notifyListeners();
  }
}
