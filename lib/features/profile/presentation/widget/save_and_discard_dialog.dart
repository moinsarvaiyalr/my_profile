import 'package:flutter/material.dart';
import 'package:flutter_practical/core/constants/app_strings.dart';
import 'package:flutter_practical/core/constants/ui_constants.dart';
import 'package:flutter_practical/core/extensions/context_extension.dart';
import 'package:flutter_practical/core/theme/color_palette.dart';
import 'package:go_router/go_router.dart';

class SaveAnDiscardDialog extends StatelessWidget {
  const SaveAnDiscardDialog({super.key, required this.onTap});

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
                AppStrings.alert,
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalMargin24,
              Text(
                AppStrings.labelPendingChanges,
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
                        context.pop();
                      },
                      child: Text(
                        AppStrings.discard,
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
                        backgroundColor: ColorPalette.colorGreen,
                      ),
                      onPressed: onTap,
                      child: Text(
                        AppStrings.save,
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
