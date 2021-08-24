import 'package:singingholic_app/providers/login_provider.dart';

class LoginRepository {
  final LoginProvider loginProvider;

  LoginRepository({required this.loginProvider});

  /// Login member account
  Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      final videoListModel =
          await this.loginProvider.login(email: email, password: password);
      return videoListModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
