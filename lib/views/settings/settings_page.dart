import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        appBar: AppBar(),
        title: 'Settings',
        hasCart: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // TODO: Implement Settings page
    return Center(
      child: Text('This is settings page'),
    );
  }
}
