import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSelector extends StatefulWidget {
  final Function onImageSelected;
  const ImageSelector({super.key, required this.onImageSelected});

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  final ImagePicker _picker = ImagePicker();


  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  Future<void> _getImageFromGallery() async {
    if (await _requestPermission(Permission.storage)) {
      try {
        final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          widget.onImageSelected(File(pickedFile.path));
        }
      } catch (e) {
        throw Exception('Error picking Image');
      }
    }
  }

  Future<void> _getImageFromCamera() async {
    if (await _requestPermission(Permission.camera)) {
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          widget.onImageSelected(File(pickedFile.path));
        }
      } catch (e) {
        throw Exception('Error picking Image');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(child: Column(
      children: [
        GestureDetector(
          onTap: _getImageFromCamera,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons. camera_enhance,
                ),
                Text(
                  "Select from Camera",
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: _getImageFromGallery,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.folder,
                ),
                Text(
                  "Select from files",
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
