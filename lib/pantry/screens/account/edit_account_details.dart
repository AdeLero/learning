import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/custom_Button.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/profile_picture/profile_picture_bottom_sheet.dart';

class EditAccountDetails extends StatefulWidget {
  const EditAccountDetails({super.key});

  @override
  State<EditAccountDetails> createState() => _EditAccountDetailsState();
}

class _EditAccountDetailsState extends State<EditAccountDetails> {
  bool isEditbuttonVisible = false;
  TextEditingController userNameController = TextEditingController();
  File? profilePicture;

  void _toggleEditButton () {
    setState(() {
      isEditbuttonVisible = !isEditbuttonVisible;
    });
  }

  void _showProfilePictureBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ProfilePictureModalBottomSheet(
            onImageSelected: (File pickedImage) {
              setState(() {
                profilePicture = pickedImage;
              });
            },
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
        GestureDetector(
        onTap: _toggleEditButton,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundImage: profilePicture != null ? FileImage(profilePicture!) : AssetImage("lib/assets/images/Profile_Picture.png") as ImageProvider,
            ),
            if (isEditbuttonVisible)
              GestureDetector(
                onTap: _showProfilePictureBottomSheet,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: TheColors.paleBlue.withOpacity(0.5),
                  ),
                  height: 100.h,
                  width: 100.h,
                  child: Center(
                    child: Icon(Icons.camera_alt_rounded),
                  ),
                ),
              )
          ],
        ),
      ),
          CustomTextbox(
            hintText: "Username",
            controller: userNameController,
          ),
          CustomButton(
            onTap: () {
              final userName = userNameController.text;
              final image = profilePicture?.path;
              BlocProvider.of<AuthBloc>(context).add(UpdateUserCredentials(userName: userName, image: image));
              Navigator.pop(context);
            },
            buttonText: "Update",
          ),
        ],
      ),
    );
  }
}
