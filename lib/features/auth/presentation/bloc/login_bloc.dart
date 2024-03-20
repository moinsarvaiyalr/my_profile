import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical/core/app_preference/app_preferences.dart';
import 'package:flutter_practical/core/app_preference/storage_keys.dart';
import 'package:flutter_practical/core/constants/app_strings.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLogin>((event, emit) {
      emit(LoginLoading());
      try {
        AppPreferences().sharedPrefWrite(StorageKeys.userName, event.userName);
        AppPreferences().sharedPrefWrite(StorageKeys.password, event.password);
        AppPreferences()
            .sharedPrefWrite(AppStrings.rememberMe, event.isRemebered);
      } catch (e) {
        emit(
          const LoginFailed(message: AppStrings.errorLogIn),
        );
      }
      emit(LoginSucess());
    });
  }
}
