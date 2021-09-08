import 'dart:ui';
import 'package:flutter/material.dart';

class Paddy {
  String status;
  Image pic;
  String steps;
  Color color;

  Paddy(this.pic, this.status) {
    if (this.status == "Healthy") {
      this.color = Colors.green;
    } else
      this.color = Colors.red;
    switch (status) {
      case "Hispa":
        this.steps = "a) Destroy leaf tips that contain blotch mines.\nb) Manual collection and killing of beetles using hand nets.\nc) Cut the shoot tips to prevent egg laying of the pests.";
        break;
      case "Brown Spot":
        this.steps = "a)Use fungicides as seed treatments.\nb)Treat seeds with hot water (53−54°C) for 10−12 minutes before planting, to control primary infection at the seedling stage. To increase effectiveness of treatment, pre-soak seeds in cold water for eight hours.";
        break;
      case "Leaf Blast":
        this.steps = "a) Remove weed hosts from bunds.\nb) Systemic fungicides such as pyroquilon and tricyclazole are possible chemicals for controlling the disease.";
        break;
      case "Healthy":
        this.steps = "This crop is healthy";
        break;
    }
  }
}
