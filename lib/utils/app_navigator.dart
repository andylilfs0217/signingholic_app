import 'package:flutter/cupertino.dart';

class AppNavigator {
  static goTo(BuildContext context, String name,
      {Object? args, Function()? then}) {
    Navigator.pushNamed(context, name, arguments: args).then((value) {
      then?.call();
    });
  }

  static drawerGoTo(BuildContext context, String name, {Object? args}) {
    if (ModalRoute.of(context)!.settings.name != name) {
      Navigator.pushNamed(context, name, arguments: args);
    } else {
      Navigator.pop(context);
    }
  }
}
