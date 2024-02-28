import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'result_screen.dart'; // Make sure to create this screen

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    print("Initializing the camera");
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras!.isNotEmpty) {
        initCamera(cameras!.first);
      }
    }).catchError((err) {
      // Handle errors here
      print("Failed to init the camera: $err");
    });
  }

  Future<void> initCamera(CameraDescription cameraDescription) async {
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    controller!.initialize().then((_) {
      print("Camera initialized successfully");
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<String> takePicture() async {
    if (!controller!.value.isInitialized) {
      print('Error: Camera not initialized');
      return '';
    }

    if (controller!.value.isTakingPicture) {
      // If a capture is already pending, do nothing.
      return '';
    }

    try {
      // Attempt to take a picture and get the file where it's saved.
      XFile file = await controller!.takePicture();

      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Pictures/flutter_test';
      await Directory(dirPath).create(recursive: true);

      // Create a unique file name with the current timestamp
      final String filePath = '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Save the picture to the custom path
      await file.saveTo(filePath);

      return filePath;
    } on CameraException catch (e) {
      // If an error occurs, log the error and return an empty path.
      print(e);
      return '';
    }
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Take your picture')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CameraPreview(controller!),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            child: Icon(Icons.camera),
            onPressed: () async {
              imagePath = await takePicture();
              if (imagePath != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(imagePath: imagePath),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
