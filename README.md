<<<<<<< HEAD
# Orez : Prototype Rice Disease Detection System
A mobile application using Flutter designed for Pixel 2 device.
Credit to Pawan for his demo of TfLite in Flutter : https://github.com/iampawan/TFLite-Flutter

<h1>Description</h1>

<p>As part of our submission to UM Hackathon 2021, we have trained a CustomVision model in Microsoft Azure and exported it into TensorFlow Lite. 
I am tasked to create a graphical user interface on mobile application for the deep learning model to predict and label images given by the user.
</p>

<h1><u>Features</u></h1>

<h2>• Intuitive and Innovative Display of Paddy Crops</h2>

<p>Our simple grid layout makes it easy and intuitive for users to navigate our app.

🟢 = Healthy
🔴 = Sick

Prototype is supposed to receive video input from drone, but since we do not have the available funds, we have used a picture of a Paddy image from the validation dataset that the model has not seen yet for each square Paddy object, and predicted the output based on our own trained learning model.
</p>

<h2>• Uses Artificial Intelligence to Predict Rise Disease</h2>

<p>
We trained a deep-learning model in Azure using the dataset given : https://www.kaggle.com/minhhuy2810/rice-diseases-image-dataset
</p>


<h2>• Access Gallery for Image Input</h2>

<p>
Gallery or Google Drive is accessible to use for input.
</p>

=======
# tflite_demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
>>>>>>> 8df4b6e (- Pulled from Pawan's repo and changed code to use CustomVision Image Classification model trained in Azure)
