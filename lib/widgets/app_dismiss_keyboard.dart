import 'package:flutter/cupertino.dart';

class AppDismissKeyboard extends StatefulWidget {
  final Widget child;

  const AppDismissKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  _AppDismissKeyboardState createState() => _AppDismissKeyboardState();
}

class _AppDismissKeyboardState extends State<AppDismissKeyboard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
