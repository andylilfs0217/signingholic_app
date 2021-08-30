import 'package:flutter/material.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        appBar: AppBar(),
        title: 'Checkout',
        hasCart: false,
      ),
      body: _buildBody(),
      hasDrawer: false,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Text('Checkout page'),
    );
  }
}
