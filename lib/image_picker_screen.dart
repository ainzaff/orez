import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerScreen extends StatefulWidget {
  static const routeName = "/image_picker_screen";
  @override
  _ImagePickerScreenHomeState createState() => _ImagePickerScreenHomeState();
}

class _ImagePickerScreenHomeState extends State<ImagePickerScreen> {
  File _image;

  double _imageWidth;
  double _imageHeight;
  bool _busy = false;

  List _recognitions;
  List _paddy;

  @override
  void initState() {
    super.initState();
    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/tflite/orezmodel.tflite",
        labels: "assets/tflite/labels.txt",
      );
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  selectFromImagePicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
    });
    predictImage(image);
  }

  predictImage(File image) async {
    if (image == null) return;
    await orezModel(image);
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));

    setState(() {
      _image = image;
      _busy = false;
    });
  }

  orezModel(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    setState(() {
      _recognitions = recognitions;
    });
  }

  List<Widget> renderBoxes() {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];
    return _recognitions.map((re) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.brown.shade600),
                child: Card(
                  margin: EdgeInsets.all(8),
                  shadowColor: Colors.red,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Orez confidence level: ",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "${(re["confidence"] * 100).toStringAsFixed(0)}%  ",
                                style: TextStyle(
                                    color: re["confidence"] > 0.8
                                        ? Colors.green
                                        : re["confidence"] > 0.5
                                            ? Colors.yellow
                                            : Colors.red,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      Text(
                        "${re["label"]} ",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.brown.shade600),
                child: Card(
                    margin: EdgeInsets.all(8),
                    shadowColor: Colors.red,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(re["label"] == "Healthy"
                          ? "This crop is healthy"
                          : re["label"] == "Hispa"
                              ? "a) Destroy leaf tips that contain blotch mines.\nb) Manual collection and killing of beetles using hand nets.\nc) Cut the shoot tips to prevent egg laying of the pests."
                              : re["label"] == "Brown Spot"
                                  ? "a)Use fungicides (i.e. iprodione, propiconazole) as seed treatments.\nb)Treat seeds with hot water (53−54°C) for 10−12 minutes before planting, to control primary infection at the seedling stage. To increase effectiveness of treatment, pre-soak seeds in cold water for eight hours."
                                  : "a) Remove weed hosts from bunds.\nb) Systemic fungicides such as pyroquilon and tricyclazole are possible chemicals for controlling the disease."),
                    )),
              ),
            )
          ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _image == null
            ? Image.asset("assets/images/no_image.png")
            : Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.brown.shade600),padding: EdgeInsets.all(8),child: Image.file(_image)),
      ),
    ));

    stackChildren.addAll(renderBoxes());

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OREZ SINGLE IMAGE MODE",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Syntha",
            color: Colors.brown,
          ),
        ),
        backgroundColor: Colors.amber.shade300,
        centerTitle: true,
        foregroundColor: Colors.brown,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade400,
        elevation: 10,
        child: Icon(Icons.image),
        tooltip: "Pick Image from gallery",
        onPressed: selectFromImagePicker,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.amber, Colors.orange.shade800])),
        child: Column(
          children: stackChildren,
        ),
      ),
    );
  }
}
