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

  //method to add new place from saveForm method in addNewPlace class by passing title & image file
  void addPlace(String newTitle, File newImage) {
    //create a model from data we got & add that mode to list
    final newPlace = PlaceModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: newTitle,
        coordinates: null,
        address: null,
        image: newImage);
    _list.add(newPlace);
    notifyListeners();
    //insert data in database in table user_places 
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  //future method to get data from database table and extracting raw data(in form of list of maps) & setting to _list
  Future<void> fetchAndSetProducts() async {
    final data = await DBHelper.getData('user_places');
    //loop through each item(map) in list and 
    //create placeModel by extracting respective data from map to respective variable & then convert to list
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
