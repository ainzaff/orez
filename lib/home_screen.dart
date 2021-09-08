import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import './image_picker_screen.dart';
import './paddy_object.dart';
import './paddy_square.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool field = false;
  List<Paddy> _paddy = [];

  List<Widget> renderPaddySquares(List<Paddy> paddy_list) {
    return paddy_list.map((re) {
      return PaddySquare(re);
    }).toList();
  }

  List<Paddy> getPaddyList() {
    List<Paddy> paddy_list = [];
for (int i = 0; i < 16; i++) {
      String stat;
      if (i == 0 ||i ==9) stat = "Leaf Blast";
      else if (i == 5 || i ==14) stat = "Brown Spot";
      else if (i == 13 || i == 15) stat = "Hispa";
      else stat = "Healthy";

      Paddy temp =
           Paddy(Image.asset("assets/images/paddy${i + 1}.jpg"), stat);

      paddy_list
          .add(temp);
    }
    return paddy_list;
  }

  @override
  Widget build(BuildContext context) {
    void toImagePickerScreen() {
      Navigator.of(context).pushNamed(ImagePickerScreen.routeName);
    }

    _paddy = getPaddyList();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => toImagePickerScreen(),
            icon: Icon(
              Icons.image,
              size: 40,
            ),
          ),
        ],
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: Image.asset(
                "assets/images/paddy.png",
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "OREZ",
              style: TextStyle(
                fontSize: 30,
                fontFamily: "Syntha",
                color: Colors.brown,
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        backgroundColor: Colors.amber.shade300,
        centerTitle: true,
        foregroundColor: Colors.brown,
      ),
      body: field == true
          ? Container(
              width: double.infinity,
                child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio:  1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 2,
                      ),
                      children: [...renderPaddySquares(_paddy),Padding(padding: EdgeInsets.all(0)),Padding(padding: EdgeInsets.all(8)),Padding(padding: EdgeInsets.all(0)),
                                  FloatingActionButton(
                    backgroundColor: Colors.amber.shade400,
                    elevation: 10,
                    onPressed: () {
                      setState(() {
                        field = false;
                      });
                    },
                    child: Icon(Icons.flight_land_sharp),
                  )],
                    ),
                
              
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.amber, Colors.orange.shade800])))
          : Container(
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/drone.png",
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.amber.shade400,
                    elevation: 10,
                    onPressed: () {
                      getPaddyList();
                      setState(() {
                        field = true;
                      });
                    },
                    child: Icon(Icons.flight_takeoff_sharp),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.amber.shade600, Colors.orange.shade900])),
            ),
    );
  }
}
