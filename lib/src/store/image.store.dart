import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class ImageStore extends ChangeNotifier {
  var images = <String>[];

  ImageStore() {
    createImageDirectory().then((_) {
      addImagePathsToList();
    });
  }

  Future<void> createImageDirectory() async {
    final imageDirectory = await _localImagePath;
    await Directory(imageDirectory).create(recursive: true);
  }

  Future<String> get _localImagePath async {
    final directory = await getApplicationDocumentsDirectory();
    final imageDirectory = '${directory.path}/images';
    return imageDirectory;
  }

  Future<void> addImage(String sourceImagePath) async {
    try {
      final imageDirectory = await _localImagePath;
      final sourceImageName = sourceImagePath.split('/').last;
      final targetImagePath = '$imageDirectory/$sourceImageName';
      await File(sourceImagePath).copy(targetImagePath);
      images.add(targetImagePath);
    } catch (e) {
      print("Failed to add image_ $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> addImagePathsToList() async {
    final imageDirectory = await _localImagePath;
    final imagePaths = Directory(imageDirectory).listSync();
    print("Image Paths: $imagePaths");
    images.addAll(imagePaths.map((e) => e.path));
  }
}
