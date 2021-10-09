import 'package:flutter/material.dart';
import 'package:places_app/Providers/place_provider.dart';
import 'package:places_app/Screens/add_new_place.dart';
import 'package:places_app/Screens/place_info.dart';
import 'package:provider/provider.dart';
import './Screens/places_list.dart';

void main() {
  runApp(Places());
}

class Places extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlacesProvider(),
      child: MaterialApp(
        home: PlacesList(),
        routes: {
          AddPlace.routeName: (c) => AddPlace(),
          PlaceInfo.routeName: (c) => PlaceInfo()
        },
      ),
    );
  }
}
