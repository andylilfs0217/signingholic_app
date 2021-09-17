import 'package:singingholic_app/providers/login_provider.dart';
import 'package:singingholic_app/providers/sign_up_provider.dart';

class SignUpRepository {
  final SignUpProvider signUpProvider;

  SignUpRepository({required this.signUpProvider});

  /// Register member account
  Future<dynamic> registerMember(
      {required String name,
      required String email,
      required String mobile,
      required String password,
      required String password2}) async {
    try {
      final result = await this.signUpProvider.registerMember(
          name: name,
          email: email,
          mobile: mobile,
          password: password,
          password2: password2);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
