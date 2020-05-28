import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nocodefront/ui/display_picture_screen/display_picture_screen.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';


// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}


class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('表格识别')),
        // Wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner
        // until the controller has finished initializing.
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22),
          backgroundColor: Color(0xFF801E48),
          visible: true,
          curve: Curves.bounceIn,
          children: [
            // FAB 1
            SpeedDialChild(
                child: Icon(Icons.camera_alt),
                backgroundColor: Color(0xFF801E48),
                onTap: () async {
                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Construct the path where the image should be saved using the
                    // pattern package.
                    final path = join(
                      // Store the picture in the temp directory.
                      // Find the temp directory using the `path_provider` plugin.
                      (await getTemporaryDirectory()).path,
                      '${DateTime.now()}.png',
                    );
                    // Attempt to take a picture and log where it's been saved.
                    await _controller.takePicture(path);

                    // If the picture was taken, display it on a new screen.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(imagePath: path),
                      ),
                    );
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  }
                }),
            // FAB 2
            SpeedDialChild(
                child: Icon(Icons.photo_album),
                backgroundColor: Color(0xFF801E48),
                onTap: () async {
                  try {
                    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(imagePath: file.path),
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                })
          ],
        )

    );
  }
}