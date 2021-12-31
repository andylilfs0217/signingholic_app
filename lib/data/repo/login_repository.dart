import 'package:singingholic_app/providers/login_provider.dart';

class LoginRepository {
  final LoginProvider loginProvider;

  LoginRepository({required this.loginProvider});

  /// Login member account
  Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      final res =
          await this.loginProvider.login(email: email, password: password);
      return res;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Logout member account
  Future<dynamic> logout() async {
    try {
      await this.loginProvider.logout();
    } catch (e) {
      throw Exception(e);
    }
  }
}
