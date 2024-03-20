import 'package:flutter/material.dart';
import 'package:flutter_practical/core/constants/app_strings.dart';
import 'package:flutter_practical/core/constants/ui_constants.dart';
import 'package:flutter_practical/core/extensions/context_extension.dart';
import 'package:flutter_practical/core/theme/color_palette.dart';
import 'package:go_router/go_router.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: horizontalPadding12 + verticalPadding24,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: horizontalPadding16 + verticalPadding12,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: CloseButton(),
              ),
              Text(
                AppStrings.logOut,
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalMargin24,
              Text(
                AppStrings.labellogOut,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              verticalMargin24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 124,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: const Color(0xffC4C4C4),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        'No',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.colorWhite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 124,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: ColorPalette.colorRed,
                      ),
                      onPressed: onTap,
                      child: Text(
                        'Yes',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.colorWhite,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              verticalMargin16,
            ],
          ),
        ),
      ),
    );
  }
}
