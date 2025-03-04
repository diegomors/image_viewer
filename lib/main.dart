import 'package:flutter/material.dart';

import 'image_picker/image_picker.dart';
import 'image_viewer/image_viewer.dart';

void main() {
  runApp(
    Material(
      child: MaterialApp(
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MyImagePicker _imagePicker = MyImagePicker();

  String? _imagePath;

  Future<void> _pickImage() async {
    final pickedImage = await _imagePicker.pickImage();
    setState(() {
      _imagePath = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick an Image')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imagePath == null ? Text("No image selected") : MyImageViewer(_imagePath!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Pick Image"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
