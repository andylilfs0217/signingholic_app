part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  /// Login email
  final String email;

  /// Login password
  final String password;

  LoginSubmitted({required this.email, required this.password}) : super();
}
