import 'dart:io';

import 'package:flutter/material.dart';

class PlaceModel {
  String id;
  String title;
  LatLng coordinates;
  String address;
  File image;
  PlaceModel(
      {@required this.id,
      @required this.title,
      @required this.coordinates,
      @required this.address,
      @required this.image});
}

class LatLng {
  double latitude;
  double longitude;
  LatLng({@required this.latitude, @required this.longitude});
}
