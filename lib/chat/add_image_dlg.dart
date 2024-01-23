import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage(this.addImageFunc, {super.key});

  final Function(File pikcedImaged) addImageFunc;

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {

  File? pickedImage;

  void pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150,
    );
    if(pickedImageFile != null ){
      setState(() {
        pickedImage = File(pickedImageFile.path);
      });
      widget.addImageFunc(pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        width: 300,
        height: 250,
        child : Column(
            children : [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                backgroundImage: pickedImage == null ? null : FileImage(pickedImage!),
              ),
              const SizedBox(height: 15.0,),
              TextButton.icon(
                onPressed: () {pickImage();},
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('pick Image'),
              ),
              const SizedBox(height: 15.0,),
              TextButton.icon(
                onPressed: () {Navigator.pop(context);},
                icon: const Icon(Icons.close),
                label: const Text('close'),
              )
            ]
        )
    );
  }
}
