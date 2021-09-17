part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpProcessingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpFailState extends SignUpState {
  final String errorMsg;

  const SignUpFailState({required this.errorMsg});
}
