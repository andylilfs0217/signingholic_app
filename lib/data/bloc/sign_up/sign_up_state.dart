part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  final siteConfig;
  const SignUpState({this.siteConfig});

  @override
  List<Object> get props => [];
}

class SignUpInitialState extends SignUpState {
  const SignUpInitialState() : super(siteConfig: const {});
}

class SignUpProcessingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpFailState extends SignUpState {
  final String errorMsg;

  const SignUpFailState({required this.errorMsg}) : super();
}

class GettingSignUpFormState extends SignUpState {}

class GetSignUpFormSuccessState extends SignUpState {
  final siteConfig;

  const GetSignUpFormSuccessState({required this.siteConfig})
      : super(siteConfig: siteConfig);
}

class GetSignUpFormFailState extends SignUpState {}
