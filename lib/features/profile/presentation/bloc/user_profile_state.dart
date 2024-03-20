part of 'user_profile_bloc.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class GetUserProfileInitial extends UserProfileState {}

final class GetUserProfileLoading extends UserProfileState {}

final class GetUserProfileFail extends UserProfileState {}

final class GetUserProfileSucess extends UserProfileState {
  final dynamic result;

  const GetUserProfileSucess({required this.result});
}

final class OnValueChangeTextField extends UserProfileState {
  final String changedValue;

  const OnValueChangeTextField({required this.changedValue});
}

final class GetAllUserProfileLoading extends UserProfileState {}

final class GetAllUserProfileFail extends UserProfileState {}

final class GetAllUsersProfileSucess extends UserProfileState {
  final String? userName;
  final String? userEmail;
  final dynamic userSkills;
  final String? startDate;
  final String? endDate;
  final String? totalExperience;
  final String? profileImage;

  const GetAllUsersProfileSucess(
      {required this.userName,
      required this.userEmail,
      required this.userSkills,
      required this.startDate,
      required this.endDate,
      required this.totalExperience,
      required this.profileImage});
}

final class EditProfilePictureLoading extends UserProfileState {}

final class EditProfilePictureSucess extends UserProfileState {
  final String image;

  const EditProfilePictureSucess({required this.image});
}

final class EditProfilePictureFail extends UserProfileState {
  final String message;

  const EditProfilePictureFail({required this.message});
}

final class LogoutUserProfileLoading extends UserProfileState {}

final class LogoutUserProfileSucess extends UserProfileState {}

final class LogoutUserProfileFail extends UserProfileState {
  final String message;

  const LogoutUserProfileFail({required this.message});
}

final class UpdateUserProfileLoading extends UserProfileState {}

final class UpdateUserProfileSucess extends UserProfileState {
  final String message;

  const UpdateUserProfileSucess({required this.message});
}

final class UpdateUserProfileFail extends UserProfileState {
  final String message;

  const UpdateUserProfileFail({required this.message});
}
