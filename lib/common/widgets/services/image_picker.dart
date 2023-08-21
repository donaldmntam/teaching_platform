
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:teaching_platform/common/functions/error_functions.dart';

abstract interface class ImagePicker {
  Future<Image?> imageFromPicker();
  Future<List<Image>> imagesFromPicker();
}

class DefaultImagePicker implements ImagePicker {
  final FilePicker _picker;

  DefaultImagePicker({
    FilePicker? picker,
  }) :
    _picker = picker ?? FilePicker.platform;

  @override
  Future<Image?> imageFromPicker() async {
    final result = await _picker.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result == null) return null;
    require(result.count == 1);
    final bytes = result.files[0].bytes;
    if (bytes == null) return null;
    return await decodeImageFromList(bytes);
  }

  @override
  Future<List<Image>> imagesFromPicker() async {
    final result = await _picker.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result == null) return [];
    final images = List<Image>.empty(growable: true);
    for (var i = 0; i < result.count; i++) {
      final bytes = result.files[i].bytes;
      if (bytes == null) continue;
      final decodedImage = await decodeImageFromList(bytes);
      images.add(decodedImage);
    }
    return images;
  }    
}