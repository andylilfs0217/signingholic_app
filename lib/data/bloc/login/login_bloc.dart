import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';
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
    if (event is InitializeLoginEvent) {
      yield LoginInitialState();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? xsession = prefs.getString('xsession');
      final String? memberString = prefs.getString('member');
      if (xsession != null && memberString != null) {
        final member = jsonDecode(memberString);
        MemberModel memberModel = MemberModel.fromJson(member);
        var storage = FlutterSecureStorage();
        await storage.write(key: 'xsession', value: xsession);
        yield LoginSuccessState(memberModel: memberModel);
      }
    }
    // Login submitted event
    if (event is LoginSubmittedEvent) {
      try {
        yield LoginProcessingState();
        var response = await loginRepository.login(
            email: event.email, password: event.password);
        if (response['succeed'] != null && response['succeed']) {
          MemberModel memberModel = MemberModel.fromJson(response['payload']);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('member', jsonEncode(memberModel.toJson()));
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
      yield LoginInitialState();
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('xsession');
        await prefs.remove('member');
        await loginRepository.logout();
      } catch (e) {}
    }
    // Update video cart
    if (event is LoginUpdateVideoCartEvent && state is LoginSuccessState) {
      state.memberModel!.videoCart = event.videoCartModel;
    }
  }
}
