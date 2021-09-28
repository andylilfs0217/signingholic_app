part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUp extends SignUpEvent {
  final String name;
  final String email;
  final Map inputFields;
  final String password;
  final String password2;

  const SignUp({
    required this.name,
    required this.email,
    required this.inputFields,
    required this.password,
    required this.password2,
  });
}

class GetSignUpFormEvent extends SignUpEvent {}
