part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersProfile extends UserProfileEvent {}

class GetUserProfile extends UserProfileEvent {
  final String key;

  const GetUserProfile({required this.key});
}

class OnValueChanged extends UserProfileEvent {
  final String input;
  const OnValueChanged(this.input);
}

class OnEditProfilePicture extends UserProfileEvent {}

class UpdateUsersProfile extends UserProfileEvent {
  final String textFieldKey;
  final dynamic updatedValue;

  const UpdateUsersProfile({
    required this.textFieldKey,
    required this.updatedValue,
  });
}

class OnLogout extends UserProfileEvent {}
