import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical/core/app_preference/app_preferences.dart';
import 'package:flutter_practical/core/app_preference/storage_keys.dart';
import 'package:flutter_practical/core/constants/app_strings.dart';
import 'package:flutter_practical/features/shared/widgets/utilities.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(GetUserProfileInitial()) {
    /// Get all User's data on profile Load
    on<GetAllUsersProfile>(
      (event, emit) async {
        emit(GetAllUserProfileLoading());
        final String? userName = await AppPreferences().sharedPrefRead(
          StorageKeys.password,
        );
        final String? userEmail = await AppPreferences().sharedPrefRead(
          StorageKeys.userName,
        );
        final dynamic userSkills = await AppPreferences().sharedPrefRead(
          AppStrings.labelSkills,
        );
        final String? startDate = await AppPreferences().sharedPrefRead(
          AppStrings.labelStartDate,
        );
        final String? endDate = await AppPreferences().sharedPrefRead(
          AppStrings.labelEndDate,
        );
        final String? totalExperience = await AppPreferences().sharedPrefRead(
          AppStrings.labelTotalExperience,
        );
        final String? profileImage = await AppPreferences().sharedPrefRead(
          AppStrings.labelProfile,
        );
        emit(
          GetAllUsersProfileSucess(
              profileImage: profileImage,
              userName: userName,
              userEmail: userEmail,
              userSkills: userSkills,
              startDate: startDate,
              endDate: endDate,
              totalExperience: totalExperience),
        );
      },
    );

    /// Get Perticular user detilas for edit page
    on<GetUserProfile>(
      (event, emit) {
        emit(GetUserProfileLoading());
        final Object? value = AppPreferences().sharedPrefRead(
          event.key,
        );
        emit(GetUserProfileSucess(result: value));
      },
    );

    /// On update Textfield
    on<OnValueChanged>(
      (event, emit) {
        emit(OnValueChangeTextField(changedValue: event.input));
        emit(GetUserProfileInitial());
      },
    );

    /// Update user's profile picture get from gallery and show image
    on<OnEditProfilePicture>(
      (event, emit) async {
        String? imagePath;
        emit(EditProfilePictureLoading());
        try {
          await Utilities.imagePicker().then(
            (value) {
              if (value is String) {
                emit(EditProfilePictureFail(message: value));
              } else {
                imagePath = value?.path;
              }
            },
          );
        } catch (e) {
          emit(const EditProfilePictureFail(message: AppStrings.errorImage));
        }
        emit(EditProfilePictureSucess(image: imagePath ?? ''));
      },
    );

    /// Update user's details on save
    on<UpdateUsersProfile>((event, emit) {
      emit(UpdateUserProfileLoading());
      AppPreferences().sharedPrefWrite(event.textFieldKey, event.updatedValue);
      emit(const UpdateUserProfileSucess(
          message: AppStrings.profileUpdatedSucess));
    });

    /// On logout Delete all User's data
    on<OnLogout>((event, emit) {
      emit(LogoutUserProfileLoading());
      try {
        AppPreferences().sharedPrefEraseAllData();
      } catch (e) {
        emit(const LogoutUserProfileFail(message: AppStrings.errorLogout));
      }

      emit(LogoutUserProfileSucess());
    });
  }
}
