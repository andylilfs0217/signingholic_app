import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    if (event is LoginSubmitted) {
      try {
        yield LoginProcessingState();
        var response = await loginRepository.login(
            email: event.email, password: event.password);
        if (response['succeed'] != null && response['succeed']) {
          yield LoginSuccessState();
        } else {
          yield LoginFailedState();
        }
      } catch (e) {
        yield LoginFailedState();
        throw Exception(e);
      }
    }
  }
}
