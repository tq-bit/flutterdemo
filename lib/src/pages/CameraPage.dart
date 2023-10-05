import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:namer_app/src/store/image.store.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatefulWidget {
  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ImageStore imageStore = context.watch<ImageStore>();
    return Column(
      children: [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: 1.0,
                child: CameraPreview(_controller),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () => _takePicture(imageStore),
            child: Text('Take picture'),
          ),
        )
      ],
    );
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.medium);
    await _controller.initialize();
  }

  Future<void> _takePicture(ImageStore imageStore) async {
    try {
      await _initializeControllerFuture;
      final XFile picture = await _controller.takePicture();
      print('Picture saved at ${picture.path}');
      await imageStore.addImage(picture.path);
    } catch (e) {
      print('Error taking picture: $e');
    }
  }
}
