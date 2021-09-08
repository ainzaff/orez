import 'package:flutter/material.dart';
import './paddy_object.dart';

class PaddyScreen extends StatefulWidget {
  static const routeName = "/paddy_screen";

  @override
  _PaddyScreenState createState() => _PaddyScreenState();
}

class _PaddyScreenState extends State<PaddyScreen> {
  @override
  Widget build(BuildContext context) {
        final routeArgs =
      ModalRoute.of(context).settings.arguments as Map<String, Paddy>;
    Paddy paddy = routeArgs["paddy"];
    final String steps = paddy.steps;
    final String status = paddy.status;
    final Color color = paddy.color;

     return Scaffold(
      appBar: AppBar(
        title: Text(
          "$status",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Syntha",
            color: color,
          ),
        ),
        backgroundColor: Colors.amber.shade300,
        centerTitle: true,
        foregroundColor: Colors.brown,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.amber, Colors.orange.shade800])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
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
                    children: [paddy.pic,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "$status",
                          style: TextStyle(
                              color: color,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
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
                      child: Text("$steps"),
                    )),
              ),
            )
          ]),
      ),
    ) ;
    }
  }
