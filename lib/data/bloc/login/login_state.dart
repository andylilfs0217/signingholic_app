part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginProcessingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailedState extends LoginState {}