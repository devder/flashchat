import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imageFn;
  UserImagePicker(this.imageFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
        return;
      }
    });
    widget.imageFn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.photo_album),
          label: Text('Add image'),
          textColor: Color(0xffCB3D3D),
        ),
      ],
    );
  }
}
