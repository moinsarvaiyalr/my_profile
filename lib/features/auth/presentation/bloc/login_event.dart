part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class OnLogin extends LoginEvent {
  final String userName;
  final String password;
  final bool isRemebered;

  const OnLogin({
    required this.isRemebered,
    required this.userName,
    required this.password,
  });
}
