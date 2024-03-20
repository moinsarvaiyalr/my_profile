import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical/core/constants/app_strings.dart';
import 'package:flutter_practical/core/constants/ui_constants.dart';
import 'package:flutter_practical/core/extensions/context_extension.dart';
import 'package:flutter_practical/core/routes/route_path.dart';
import 'package:flutter_practical/core/snackbar_message.dart';
import 'package:flutter_practical/core/theme/color_palette.dart';
import 'package:flutter_practical/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:flutter_practical/features/profile/presentation/widget/profile_image_widget.dart';
import 'package:flutter_practical/features/profile/presentation/widget/save_and_discard_dialog.dart';
import 'package:flutter_practical/features/shared/widgets/utilities.dart';
import 'package:go_router/go_router.dart';

typedef EditProfileScreenData = ({
  String label,
  String? hint,
});

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final EditProfileScreenData userData;

  static Widget routeBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    final userData = state.extra as EditProfileScreenData;
    return BlocProvider(
      create: (context) => UserProfileBloc()
        ..add(
          GetUserProfile(
            key: userData.label,
          ),
        ),
      child: EditProfileScreen(userData: userData),
    );
  }

  static navigateTo(
      BuildContext context, EditProfileScreenData userData) async {
    await context.push(RoutePath.editProfile, extra: userData);
    // ignore: use_build_context_synchronously
    context.read<UserProfileBloc>().add(GetAllUsersProfile());
  }

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController textEditingController = TextEditingController();
  String initTextValue = '';
  final ValueNotifier<List<String>> skills = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is GetUserProfileSucess) {
          if (state.result is String) {
            textEditingController.text = state.result ?? '';
            initTextValue = state.result;
          } else if (state.result is List<dynamic>) {
            state.result.isNotEmpty
                ? state.result.forEach((element) => skills.value.add(element))
                : null;
            initTextValue = skills.value.length.toString();
          } else if (widget.userData.label == AppStrings.labelSkills) {
            initTextValue = skills.value.length.toString();
          }
        } else if (state is OnValueChangeTextField) {
          textEditingController.text = state.changedValue;
          if (widget.userData.label == AppStrings.labelSkills) {
            skills.value.add(textEditingController.text);
            textEditingController.clear();
          }
        } else if (state is UpdateUserProfileSucess) {
          ShowMessage.errorMessage(context, state.message);
          context.pop();
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (_) {
            if ((initTextValue != textEditingController.text.trim() &&
                    widget.userData.label != AppStrings.labelSkills) ||
                (widget.userData.label == AppStrings.labelSkills &&
                    skills.value.length.toString() != initTextValue &&
                    skills.value.isNotEmpty)) {
              showDialog(
                context: context,
                builder: (_) => SaveAnDiscardDialog(
                  onTap: () {
                    if (initTextValue != textEditingController.text.trim() &&
                        widget.userData.label != AppStrings.labelSkills) {
                      context.read<UserProfileBloc>().add(
                            UpdateUsersProfile(
                              textFieldKey: widget.userData.label,
                              updatedValue: textEditingController.text.trim(),
                            ),
                          );
                    } else {
                      context.read<UserProfileBloc>().add(
                            UpdateUsersProfile(
                              textFieldKey: widget.userData.label,
                              updatedValue: skills.value,
                            ),
                          );
                    }
                    context.pop();
                  },
                ),
              );
            } else {
              context.pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('${AppStrings.edit} ${widget.userData.label}'),
            ),
            backgroundColor: ColorPalette.colorWhite,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    horizontalPadding24 + verticalPadding16 + verticalPadding4,
                child: widget.userData.label == AppStrings.labelProfile
                    ? BlocListener<UserProfileBloc, UserProfileState>(
                        listener: (context, state) {
                          if (state is EditProfilePictureFail) {
                            ShowMessage.errorMessage(context, state.message);
                          } else if (state is EditProfilePictureSucess) {
                            textEditingController.text = state.image;
                          }
                        },
                        child: Center(
                          child: ProfilePictureWidget(
                            profilePicture: textEditingController.text,
                            onProfilePictureTap: () {
                              context
                                  .read<UserProfileBloc>()
                                  .add(OnEditProfilePicture());
                            },
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            readOnly:
                                AppStrings.hintdate == widget.userData.hint
                                    ? true
                                    : false,
                            controller: textEditingController,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: widget.userData.hint,
                            ),
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                context.read<UserProfileBloc>().add(
                                      OnValueChanged(value),
                                    );
                              }
                            },
                            onChanged: (val) {
                              if (widget.userData.label ==
                                  AppStrings.labelSkills) {
                              } else {
                                context.read<UserProfileBloc>().add(
                                      OnValueChanged(val),
                                    );
                              }
                            },
                            onTap: AppStrings.hintdate == widget.userData.hint
                                ? () {
                                    Utilities.openDatePicker(
                                      context,
                                      startDate: initTextValue.isNotEmpty
                                          ? DateTime.parse(initTextValue)
                                          : DateTime.now(),
                                      endDate: DateTime.now(),
                                      firstDate: DateTime(1975),
                                    ).then(
                                      (value) {
                                        if (value != null) {
                                          context.read<UserProfileBloc>().add(
                                                OnValueChanged(
                                                  Utilities.dateFormate(value),
                                                ),
                                              );
                                        }
                                      },
                                    );
                                  }
                                : null,
                          ),
                          verticalMargin4,
                          Visibility(
                            visible:
                                widget.userData.label == AppStrings.labelSkills,
                            child: Text(
                              AppStrings.hintSkills,
                              textAlign: TextAlign.start,
                              style: context.textTheme.labelMedium!.copyWith(
                                color: ColorPalette.colorBlack,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          verticalMargin12,
                          ValueListenableBuilder(
                            valueListenable: skills,
                            builder: (context, value, child) => Visibility(
                              visible: value.isNotEmpty,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: List.generate(
                                    value.length,
                                    (index) => Padding(
                                      padding: horizontalPadding4,
                                      child: Chip(
                                        backgroundColor:
                                            ColorPalette.primaryColor,
                                        label: Text(
                                          value[index],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: ColorPalette.colorWhite,
                                          ),
                                        ),
                                        deleteIconColor:
                                            ColorPalette.colorWhite,
                                        iconTheme: const IconThemeData(
                                          color: ColorPalette.colorWhite,
                                        ),
                                        deleteIcon: const Icon(
                                          Icons.close,
                                          size: 16,
                                        ),
                                        onDeleted: () {
                                          skills.value.removeAt(index);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: allPadding12 + allPadding8,
              child: ValueListenableBuilder(
                valueListenable: skills,
                builder: (context, value, _) {
                  return ElevatedButton(
                    onPressed: initTextValue !=
                                textEditingController.text.trim() &&
                            widget.userData.label != AppStrings.labelSkills
                        ? () {
                            context.read<UserProfileBloc>().add(
                                  UpdateUsersProfile(
                                    textFieldKey: widget.userData.label,
                                    updatedValue:
                                        textEditingController.text.trim(),
                                  ),
                                );
                          }
                        : value.length.toString() != initTextValue &&
                                widget.userData.label == AppStrings.labelSkills
                            ? () {
                                context.read<UserProfileBloc>().add(
                                      UpdateUsersProfile(
                                        textFieldKey: widget.userData.label,
                                        updatedValue: skills.value,
                                      ),
                                    );
                              }
                            : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return ColorPalette.colorGrey;
                          }
                          return ColorPalette.primaryColor;
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: const Text(
                      AppStrings.save,
                      style: TextStyle(
                        color: ColorPalette.colorWhite,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
