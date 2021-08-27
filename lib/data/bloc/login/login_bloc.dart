import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:singingholic_app/data/bloc/cart/cart_bloc.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/repo/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// Login repository
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // Login submitted event
    if (event is LoginSubmittedEvent) {
      try {
        yield LoginProcessingState();
        var response = await loginRepository.login(
            email: event.email, password: event.password);
        if (response['succeed'] != null && response['succeed']) {
          MemberModel memberModel = MemberModel.fromJson(response['payload']);
          yield LoginSuccessState(memberModel: memberModel);
        } else {
          yield LoginFailedState();
        }
      } catch (e) {
        yield LoginFailedState();
        throw Exception(e);
      }
    }
    // Logout event
    if (event is LogoutEvent) {
      // TODO: implement logout api
      yield LoginInitialState();
    }
  }
}
