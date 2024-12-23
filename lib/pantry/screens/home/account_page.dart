import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/custom_widgets/custom_Button.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/screens/account/edit_account_details.dart';
import 'package:my_learning/pantry/screens/auth/pantry_sign_in.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PantrySignIn()));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                final user = state.user;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: user.photoURL != null &&
                                      user.photoURL!.isNotEmpty
                                  ? FileImage(File(user.photoURL!))
                                  : const AssetImage(
                                      "lib/assets/images/Profile_Picture.png"),
                              radius: 50.r,
                            ),
                            Text(
                              user.displayName ?? "Username",
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      YMargin(16.h),
                      CustomButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditAccountDetails()));
                        },
                        buttonText: "Edit Account",
                        buttonColor: pantryTheme.primaryColor,
                      ),
                      YMargin(16.h),
                      CustomButton(
                        onTap: () {
                          authBloc.add(AuthSignedOut());
                        },
                        buttonText: "Sign Out",
                        buttonColor: pantryTheme.primaryColor,
                      ),
                    ],
                  ),
                  // TODO Create a page for checking the history
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
