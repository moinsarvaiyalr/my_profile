import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical/core/app_preference/storage_keys.dart';
import 'package:flutter_practical/features/auth/presentation/widgets/logout_confirmation_dialog.dart';
import 'package:flutter_practical/features/profile/presentation/widget/edit_suffix_icon_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_practical/core/constants/app_strings.dart';
import 'package:flutter_practical/core/constants/ui_constants.dart';
import 'package:flutter_practical/core/extensions/context_extension.dart';
import 'package:flutter_practical/core/routes/route_path.dart';
import 'package:flutter_practical/core/theme/color_palette.dart';
import 'package:flutter_practical/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:flutter_practical/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:flutter_practical/features/profile/presentation/widget/profile_image_widget.dart';
import 'package:flutter_practical/features/shared/widgets/utilities.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  static Widget routeBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return BlocProvider(
      create: (context) => UserProfileBloc()..add(GetAllUsersProfile()),
      child: const UserProfileScreen(),
    );
  }

  static navigateTo(BuildContext context) {
    context.go(RoutePath.profile);
  }

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  List<String> skills = [];
  String experience = '';
  String profileImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.colorWhite,
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => LogoutConfirmationDialog(
                  onTap: () {
                    context.read<UserProfileBloc>().add(
                          OnLogout(),
                        );
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: ColorPalette.primaryColor,
              size: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: horizontalPadding16,
          child: BlocConsumer<UserProfileBloc, UserProfileState>(
            listener: (context, state) {
              if (state is GetAllUsersProfileSucess) {
                skills.clear();
                experience = '';
                _nameController.text = state.userName ?? '';
                _emailController.text = state.userEmail ?? '';

                if (state.userSkills != null) {
                  state.userSkills.forEach((element) => skills.add(element));
                }

                _startDateController.text = state.startDate ?? '';
                _endDateController.text = state.endDate ?? '';
                experience = state.totalExperience ?? '';
                profileImage = state.profileImage ?? '';
                _startDateController.text.isNotEmpty &&
                        _endDateController.text.isNotEmpty
                    ? experience = Utilities.yearExperience(
                        DateTime.parse(_startDateController.text),
                        DateTime.parse(_endDateController.text))
                    : null;
              }
              if (state is LogoutUserProfileSucess) {
                context.go(RoutePath.intialRoute);
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocListener<UserProfileBloc, UserProfileState>(
                    listener: (context, state) {
                      if (state is EditProfilePictureSucess) {}
                    },
                    child: Stack(
                      children: [
                        ProfilePictureWidget(
                          profilePicture: profileImage,
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Visibility(
                            visible: profileImage.isNotEmpty,
                            child: GestureDetector(
                              onTap: () => EditProfileScreen.navigateTo(
                                context,
                                (
                                  label: AppStrings.labelProfile,
                                  hint: null,
                                ),
                              ),
                              child: Container(
                                padding: allPadding4,
                                decoration: BoxDecoration(
                                  color: ColorPalette.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: ColorPalette.colorWhite,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalMargin48,
                  TextFormField(
                    controller: _nameController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: AppStrings.hintEnterYourName,
                      suffixIcon: EditSuffixIconWidget(
                        onEditTap: () {
                          EditProfileScreen.navigateTo(
                            context,
                            (
                              label: StorageKeys.password,
                              hint: AppStrings.hintEnterYourName,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  verticalMargin16,
                  TextFormField(
                    controller: _emailController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: AppStrings.hintEnterYourEmail,
                      suffixIcon: EditSuffixIconWidget(
                        onEditTap: () {
                          EditProfileScreen.navigateTo(
                            context,
                            (
                              label: StorageKeys.userName,
                              hint: AppStrings.hintEnterYourEmail,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  verticalMargin16,
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: AppStrings.hintEnterYourSkills,
                      suffixIcon: EditSuffixIconWidget(
                        onEditTap: () {
                          EditProfileScreen.navigateTo(
                            context,
                            (
                              label: AppStrings.labelSkills,
                              hint: AppStrings.hintEnterYourSkills,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: skills.isNotEmpty,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        children: List.generate(
                          skills.length,
                          (index) => Padding(
                            padding: horizontalPadding4,
                            child: Chip(
                              backgroundColor: ColorPalette.primaryColor,
                              label: Text(
                                skills[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: ColorPalette.colorWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  verticalMargin16,
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _startDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: AppStrings.labelStartDate,
                            suffixIcon: EditSuffixIconWidget(
                              onEditTap: () {
                                EditProfileScreen.navigateTo(
                                  context,
                                  (
                                    label: AppStrings.labelStartDate,
                                    hint: AppStrings.hintdate,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      horizontalMargin12,
                      Expanded(
                        child: TextFormField(
                          controller: _endDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: AppStrings.labelEndDate,
                            suffixIcon: EditSuffixIconWidget(
                              onEditTap: () {
                                EditProfileScreen.navigateTo(
                                  context,
                                  (
                                    label: AppStrings.labelEndDate,
                                    hint: AppStrings.hintdate,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalMargin12,
                  Visibility(
                    visible: experience.isNotEmpty,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${AppStrings.hintExperience} $experience',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: ColorPalette.colorBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
