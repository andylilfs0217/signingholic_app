import 'package:flutter/material.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/widgets/app_drawer.dart';

/// Base Scaffold of the App
class AppScaffold extends StatefulWidget {
  /// Appbar of the scaffold
  final PreferredSizeWidget? appBar;

  /// Body of the scaffold
  final Widget body;

  /// If it has a drawer
  final bool hasDrawer;

  const AppScaffold(
      {Key? key, this.appBar, required this.body, this.hasDrawer = true})
      : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  /// Create the scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: buildBody(),
      drawer: widget.hasDrawer ? AppDrawer() : null,
    );
  }

  /// Create the body of the scaffold
  Widget buildBody() {
    return Container(
      padding: AppThemeSize.screenPadding,
      width: MediaQuery.of(context).size.width,
      child: widget.body,
    );
  }

  /// Action on bottom nav bar click
  void onClick(int index) {
    setState(() {
      bottomNavBarIndex = index;
    });
  }
}
