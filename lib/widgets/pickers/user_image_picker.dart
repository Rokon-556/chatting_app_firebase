
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(XFile pickImage) imagePickFn;
  const UserImagePicker({super.key, required this.imagePickFn});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

XFile? _pickedImage;

void _captureImage()async{
  final pickedImageFile= await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 50,maxWidth: 150);
  setState(() {
    _pickedImage=pickedImageFile;
  });
  widget.imagePickFn(pickedImageFile!);
}

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(radius: 40,backgroundColor: Colors.grey,backgroundImage: _pickedImage!=null? FileImage(File(_pickedImage!.path)): null),
      TextButton.icon(onPressed: _captureImage, icon: Icon(Icons.image), label: Text('Pick Image'))
    ],);
  }
}