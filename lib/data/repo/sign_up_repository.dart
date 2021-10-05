import 'package:singingholic_app/providers/sign_up_provider.dart';

class SignUpRepository {
  final SignUpProvider signUpProvider;

  SignUpRepository({required this.signUpProvider});

  /// Register member account
  Future<dynamic> registerMember(
      {required String name,
      required String email,
      required Map inputFields,
      required String password,
      required String password2}) async {
    try {
      final result = await this.signUpProvider.registerMember(
            name: name,
            email: email,
            inputFields: inputFields,
            password: password,
            password2: password2,
          );
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Get member registration config
  Future<dynamic> getMemberRegistrationConfig() async {
    try {
      final result = await this.signUpProvider.getMemberRegistrationConfig();
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
