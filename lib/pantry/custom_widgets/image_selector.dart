import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _getImageFromCamera,
          child: Container(
            width: 150.w,
            height: 100.h,
            decoration: BoxDecoration(
              border: Border.all(color: pantryTheme.primaryColor, width: 2.w),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.photo_camera_rounded,
              size: 48,
              color: pantryTheme.primaryColor,
            ),
          ),
        ),
        GestureDetector(
          onTap: _getImageFromGallery,
          child: Container(
            width: 150.w,
            height: 100.h,
            decoration: BoxDecoration(
              border: Border.all(color: pantryTheme.primaryColor, width: 2.w),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.add,
              size: 48,
              color: pantryTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
