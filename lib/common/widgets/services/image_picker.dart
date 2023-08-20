
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as lib;

abstract interface class ImagePicker {
  Future<ImageProvider?> imageFromPicker();
  Future<List<ImageProvider>?> imagesFromPicker();
}

class DefaultImagePicker implements ImagePicker {
  final lib.ImagePicker _picker;

  DefaultImagePicker({
    lib.ImagePicker? picker,
  }) :
    _picker = picker ?? lib.ImagePicker();

  @override
  Future<ImageProvider?> imageFromPicker() async {
    final file = await _picker.pickImage(source: lib.ImageSource.gallery);
    // try {
    //   final bytes = await file.readAsBytes();
    // }
  }

  @override
  Future<List<ImageProvider>?> imagesFromPicker() => Future.value(null);
    // ImagePickerWeb.getMultiImagesAsFile();
}