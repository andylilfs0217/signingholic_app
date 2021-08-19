import 'package:flutter/material.dart';
import 'package:singingholic_app/assets/app_theme.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  _AppFooterState createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(AppThemeSize.defaultItemVerticalPaddingSize),
      child: Container(
        width: double.infinity,
        child: Center(
            child: Text(
          'Powered by ThinkShops',
          style: Theme.of(context).textTheme.overline,
        )),
      ),
    );
  }
}
