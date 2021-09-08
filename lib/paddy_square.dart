import 'package:flutter/material.dart';
import "./paddy_object.dart";
import './paddy_screen.dart';

class PaddySquare extends StatefulWidget {
  Paddy paddy;

  PaddySquare(this.paddy);

  @override
  _PaddySquareState createState() => _PaddySquareState();
}

class _PaddySquareState extends State<PaddySquare> {
  @override
  Widget build(BuildContext context) {
    changeToPaddyScreen(){
Navigator.of(context).pushNamed(PaddyScreen.routeName,arguments: {
        'paddy': widget.paddy,
      });
}
    return InkWell(onTap: ()=> changeToPaddyScreen(),borderRadius: BorderRadius.circular(4),splashColor: Colors.amber,
      child: Card(
        child: Icon(Icons.spa_outlined),
        color: widget.paddy.color,
      ),
    );
  }
}
