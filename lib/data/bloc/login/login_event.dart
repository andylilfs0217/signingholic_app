part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitializeLoginEvent extends LoginEvent {}

class LoginSubmittedEvent extends LoginEvent {
  /// Login email
  final String email;

  /// Login password
  final String password;

  LoginSubmittedEvent({required this.email, required this.password}) : super();
}

class LogoutEvent extends LoginEvent {}

class LoginUpdateVideoCartEvent extends LoginEvent {
  /// Video cart
  final VideoCartModel videoCartModel;

  const LoginUpdateVideoCartEvent({required this.videoCartModel}) : super();
}
