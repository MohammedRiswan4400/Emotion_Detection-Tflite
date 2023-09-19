import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:ml_emotion/main.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = "";

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadmodel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,

        width: double.infinity,
        // height: ,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                children: [
                  Image.network(
                    "https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExeGdzajN6MmpwY3c4amNxMjZsbHl4eHkwcDU3cjZ2Z2R2ZGh1dGw3NiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/V4NSR1NG2p0KeJJyr5/giphy.gif",
                  ),
                  Image.network(
                    "https://i.seadn.io/gae/_YIoKz_EmInCKgtGbJzUSpn8Liz7Mr4UIZN7aCJoCknVKkRDyWJIXe4koNnIMg84DEu4Y-32cNF5OWVnA1RuAZUotmyen_FZAe_O9Q?auto=format&dpr=1&w=1000",
                  ),
                  Image.network(
                    "https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExeGdzajN6MmpwY3c4amNxMjZsbHl4eHkwcDU3cjZ2Z2R2ZGh1dGw3NiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/V4NSR1NG2p0KeJJyr5/giphy.gif",
                    // fit: BoxFit.cover,
                  ),
                  Image.network(
                    "https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExeGdzajN6MmpwY3c4amNxMjZsbHl4eHkwcDU3cjZ2Z2R2ZGh1dGw3NiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/V4NSR1NG2p0KeJJyr5/giphy.gif",
                    // fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Emotions",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: !cameraController!.value.isInitialized
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 0, 196, 7),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AspectRatio(
                                aspectRatio:
                                    cameraController!.value.aspectRatio,
                                child: CameraPreview(
                                  cameraController!,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                      color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      output,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      for (var element in predictions!) {
        setState(
          () {
            output = element["label"];
          },
        );
      }
    }
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }
}
