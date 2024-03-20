import 'package:flutter/material.dart';
import 'package:flutter_practical/core/constants/ui_constants.dart';
import 'package:flutter_practical/core/theme/color_palette.dart';

class EditSuffixIconWidget extends StatelessWidget {
  const EditSuffixIconWidget({super.key, required this.onEditTap});

  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEditTap,
      child: Padding(
        padding: leftPadding8 + rightPadding12,
        child: const Icon(
          Icons.edit,
          color: ColorPalette.primaryColor,
        ),
      ),
    );
  }
}
