import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagesTabScreen extends StatefulWidget {
  ImagesTabScreen({super.key});

  @override
  State<ImagesTabScreen> createState() => _ImagesTabScreenState();
}

class _ImagesTabScreenState extends State<ImagesTabScreen> {
  final ImagePicker picker = ImagePicker();

  List<File> _image = [];

  Future chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('no image picked');
    } else {
      setState(() {
        _image.add(
          File(pickedFile.path),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text('Images');
  }
}
