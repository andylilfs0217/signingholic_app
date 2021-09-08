part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final MemberModel? memberModel;
  const LoginState({this.memberModel});

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {
  const LoginInitialState() : super(memberModel: null);
}

class LoginProcessingState extends LoginState {
  const LoginProcessingState() : super(memberModel: null);
}

class LoginSuccessState extends LoginState {
  final MemberModel memberModel;

  LoginSuccessState({required this.memberModel})
      : super(memberModel: memberModel);
}

class LoginFailedState extends LoginState {
  const LoginFailedState() : super(memberModel: null);
}
