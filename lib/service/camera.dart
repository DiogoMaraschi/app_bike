import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class Camera {
  String? imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<File?> captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      imageQuality: 80,
    );
    if (pickedFile == null) {
    return null;
      }

    // 2. Get the permanent directory path
    final directory = await getApplicationDocumentsDirectory();

    // 3. Extract the original file name
    final String fileName = p.basename('teste.jpg');

    final savedImage = await File(pickedFile.path).copy('assets/images/$fileName');

    return savedImage;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Camera Example')),
  //     body: Center(
  //       child: _imageFile == null
  //           ? const Text('No image captured')
  //           : Image.file(_imageFile!),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _captureImage,
  //       child: const Icon(Icons.camera_alt),
  //     ),
  //   );
  // }
}
