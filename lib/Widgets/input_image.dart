import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';

class InputImage extends StatefulWidget {
  final Function sendImage;
  InputImage(this.sendImage);
  @override
  _InputImageState createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File selectedImage;

  Future<void> getImage() async {
    final _picker =
        ImagePicker(); //using package instatiate imagepicker() and await for user to pcik image from camera or gallery
    final pickedImage = await _picker.pickImage(
        source: ImageSource.camera, maxWidth: 600, maxHeight: 600);
    setState(() {
      selectedImage = File(pickedImage.path);
      widget.sendImage(selectedImage);
    });
    //set that temporary image selected to selctedImage and rebuild the widget to display preview on UI
    final appDirectory = await PathProvider.getApplicationDocumentsDirectory();
    //android provides a specific location to store app data. So get that location using PathProvider package & store it is variable
    final fileName = path.basename(pickedImage.path);
    selectedImage.copy('${appDirectory.path}/$fileName');
    //get fileName of captured photo using basename getter which extracts the last part of path or name of file by its path
    //then finally copy our file/image to that location
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 160,
            decoration:
                BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
            child: selectedImage != null
                ? Image.file(
                    selectedImage,
                    fit: BoxFit.fill,
                  )
                : Center(
                    child: Text('No image chosen'),
                  ),
          ),
          Expanded(
            child: Center(
              child: TextButton.icon(
                  onPressed: getImage,
                  icon: Icon(Icons.photo_camera),
                  label: Text('capture/choose photo')),
            ),
          )
        ],
      ),
    );
  }
}
