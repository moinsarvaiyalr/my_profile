import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical/core/constants/app_strings.dart';
import 'package:flutter_practical/core/constants/ui_constants.dart';
import 'package:flutter_practical/core/extensions/context_extension.dart';
import 'package:flutter_practical/core/snackbar_message.dart';
import 'package:flutter_practical/core/theme/color_palette.dart';
import 'package:flutter_practical/core/validators/form_field_validators.dart';
import 'package:flutter_practical/features/auth/presentation/bloc/login_bloc.dart';
import 'package:flutter_practical/features/profile/presentation/screen/user_profile_screen.dart';
import 'package:flutter_practical/features/shared/widgets/space_vertical.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _userNameController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  final ValueNotifier<bool> _isRememberMeChecked = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: ColorPalette.colorWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: horizontalPadding24,
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpaceVertical(context.height * 0.20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.login,
                      style: context.textTheme.displayLarge?.copyWith(
                        color: ColorPalette.primaryColor,
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  verticalMargin32,
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _userNameController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: AppStrings.hintUserName,
                      prefixIcon: Icon(
                        Icons.person,
                        color: ColorPalette.primaryColor,
                        size: 24,
                      ),
                    ),
                    validator: FormFieldValidators.emailValidator,
                  ),
                  verticalMargin16,
                  ValueListenableBuilder(
                    valueListenable: isPasswordVisible,
                    builder: (context, isVisible, _) {
                      return TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _passwordController,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: ColorPalette.primaryColor,
                            size: 24,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              isPasswordVisible.value =
                                  !isPasswordVisible.value;
                            },
                            child: Padding(
                              padding: leftPadding8 + rightPadding12,
                              child: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 24,
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            maxHeight: 24,
                            maxWidth: 42,
                          ),
                        ),
                        validator: FormFieldValidators.passwordValidator,
                      );
                    },
                  ),
                  verticalMargin4,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'At least one uppercase letter,\nAt least one lowercase letter\nAt leastone digit,\nAt least one special character,\nand be at least 6 characters long.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  verticalMargin16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _isRememberMeChecked,
                        builder: (context, value, _) {
                          return Checkbox(
                            value: value,
                            onChanged: (val) {
                              _isRememberMeChecked.value = val ?? false;
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                width: 2.0,
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                            checkColor: ColorPalette.colorWhite,
                            activeColor: ColorPalette.primaryColor,
                          );
                        },
                      ),
                      Text(
                        AppStrings.rememberMe,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  verticalMargin16,
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginFailed) {
                        ShowMessage.errorMessage(
                            context, AppStrings.errorLogIn);
                      } else if (state is LoginSucess) {
                        UserProfileScreen.navigateTo(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorPalette.primaryColor,
                          ),
                        );
                      }

                      return ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                                  OnLogin(
                                    isRemebered: _isRememberMeChecked.value,
                                    userName: _userNameController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                        child: Text(
                          AppStrings.login.toUpperCase(),
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: ColorPalette.colorWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _isRememberMeChecked.dispose();
    super.dispose();
  }
}
