import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/Providers/place_provider.dart';
import 'package:places_app/Widgets/input_image.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  File _imageFile;

  void getImage(File image) {
    _imageFile = image;
  }

  void _saveForm() {
    if (_titleController.text == null || _imageFile == null) {
      return;
    }
    Provider.of<PlacesProvider>(context)
        .addPlace(_titleController.text, _imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.done,
              ),
              tooltip: 'Save changes',
              onPressed: _saveForm)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
            ),
            InputImage(getImage)
          ],
        ),
      ),
    );
  }
}
