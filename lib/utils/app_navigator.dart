import 'package:flutter/cupertino.dart';

class AppNavigator {
  static goTo(BuildContext context, String name, {Object? args}) {
    Navigator.pushNamed(context, name, arguments: args);
  }

  static drawerGoTo(BuildContext context, String name, {Object? args}) {
    if (ModalRoute.of(context)!.settings.name != name) {
      Navigator.pushNamed(context, name, arguments: args);
    } else {
      Navigator.pop(context);
    }
  }
}
