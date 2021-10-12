import 'package:flutter/material.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';

class AppLoginButton extends StatelessWidget {
  const AppLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        AppNavigator.drawerGoTo(context, AppRoute.LOGIN);
      },
      child: const Text('Login/Sign up'),
    );
  }
}
