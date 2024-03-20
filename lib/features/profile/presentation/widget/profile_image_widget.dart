import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_practical/core/constants/app_strings.dart';
// import 'package:flutter_practical/core/extensions/context_extension.dart';
import 'package:flutter_practical/core/theme/color_palette.dart';
import 'package:flutter_practical/features/profile/presentation/screen/edit_profile_screen.dart';

class ProfilePictureWidget extends StatelessWidget {
  final VoidCallback? onProfilePictureTap;
  final String profilePicture;
  const ProfilePictureWidget({
    Key? key,
    this.onProfilePictureTap,
    required this.profilePicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onProfilePictureTap != null) {
          onProfilePictureTap?.call();
        } else if (profilePicture.isEmpty) {
          EditProfileScreen.navigateTo(
            context,
            (
              label: AppStrings.labelProfile,
              hint: null,
            ),
          );
        }
      },
      child: CircleAvatar(
        backgroundColor: ColorPalette.colorLightGrey,
        backgroundImage: profilePicture.isNotEmpty
            ? FileImage(
                File(profilePicture),
              )
            : null,
        radius: 60,
        child: Visibility(
          visible: profilePicture.isEmpty,
          child: const Icon(
            Icons.add,
            size: 50,
            color: ColorPalette.primaryColor,
          ),
        ),
      ),
    );
  }
}
