import 'package:flutter/material.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';

class ProfilePage extends StatefulWidget {
  final MemberModel memberModel;

  const ProfilePage({Key? key, required this.memberModel}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        appBar: AppBar(),
        title: 'Profile',
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(children: [
      _buildName(),
      _buildEmail(),
      _buildTier(),
      _buildPoints(),
    ]);
  }

  Widget _buildName() {
    return Text(widget.memberModel.name ?? '');
  }

  Widget _buildEmail() {
    return Text(widget.memberModel.email ?? '');
  }

  Widget _buildTier() {
    return Text(widget.memberModel.tier?.name ?? '');
  }

  Widget _buildPoints() {
    return Text('My point: ${widget.memberModel.points}');
  }
}
