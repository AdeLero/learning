import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePictureModalBottomSheet extends StatefulWidget {
  final Function(File) onImageSelected;
  const ProfilePictureModalBottomSheet(
      {super.key, required this.onImageSelected});

  @override
  State<ProfilePictureModalBottomSheet> createState() =>
      _ProfilePictureModalBottomSheetState();
}

class _ProfilePictureModalBottomSheetState
    extends State<ProfilePictureModalBottomSheet> {
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
          Navigator.pop(context);
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
          Navigator.pop(context);
        }
      } catch (e) {
        throw Exception('Error picking Image');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: TheColors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit Profile Picture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: TheColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              GestureDetector(
                onTap: _getImageFromGallery,
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: TheColors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: TheColors.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Choose Photo'),
                      Icon(
                        Icons.photo,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _getImageFromCamera,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: TheColors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: TheColors.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Take Photo'),
                      Icon(
                        Icons.camera,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
