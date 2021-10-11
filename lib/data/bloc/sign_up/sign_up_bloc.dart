import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:singingholic_app/data/repo/sign_up_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  /// Sign up repository
  final SignUpRepository signUpRepository;
  SignUpBloc({required this.signUpRepository}) : super(SignUpInitialState());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUp) {
      try {
        yield SignUpProcessingState();
        var response = await signUpRepository.registerMember(
          email: event.email,
          name: event.name,
          inputFields: event.inputFields,
          password: event.password,
          password2: event.password2,
        );
        if (response['succeed'] != null && response['succeed']) {
          yield SignUpSuccessState();
        } else {
          yield SignUpFailState(
              errorMsg: response['error'] ?? 'Error occurred when signing up');
        }
      } catch (e) {
        yield SignUpFailState(errorMsg: 'Error occurred when signing up');
        throw Exception(e);
      }
    }
    if (event is GetSignUpFormEvent) {
      try {
        yield GettingSignUpFormState();
        var response = await signUpRepository.getMemberRegistrationConfig();
        if (response['succeed'] != null && response['succeed']) {
          var payload = response['payload'];
          var account = payload?['account'];
          var siteConfigString = account?['siteConfig'];
          var siteConfig =
              siteConfigString != null ? jsonDecode(siteConfigString) : {};
          yield GetSignUpFormSuccessState(siteConfig: siteConfig);
        } else {
          yield GetSignUpFormFailState();
        }
      } catch (e) {
        yield GetSignUpFormFailState();
        throw Exception(e);
      }
    }
  }
}
