import 'dart:io';
import 'package:flutter/material.dart';
import 'package:namer_app/src/store/image.store.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageStore>(builder: ((context, value, child) {
      ImageStore imageStore = context.watch<ImageStore>();
      print(imageStore.images);
      if (imageStore.images.isEmpty) {
        return Center(
          child: Text("No images yet"),
        );
      }
      return SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("You have ${imageStore.images.length} images"),
          ),
          for (var imagePath in imageStore.images)
            Card(
                child: Column(
              children: [
                Text(imagePath),
                Image.file(
                  File(imagePath),
                ),
              ],
            ))
        ]),
      );
    }));
  }
}
