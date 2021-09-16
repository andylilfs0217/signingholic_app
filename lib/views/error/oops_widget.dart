import 'package:flutter/material.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';

/// A widget for displaying some error message
class OopsWidget extends StatelessWidget {
  /// A text message that will be displayed in the middle
  final String message;

  const OopsWidget({Key? key, this.message = 'Something goes wrong.'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error),
          SizedBox(height: 10),
          Text('Oops!'),
          SizedBox(height: 10),
          Text(message),
          SizedBox(height: 10),
          ElevatedButton.icon(
              onPressed: () {
                AppNavigator.goTo(context, AppRoute.HOME);
              },
              icon: Icon(Icons.home),
              label: Text('Go back to home page'))
        ],
      ),
    );
  }
}
