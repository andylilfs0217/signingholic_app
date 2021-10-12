import 'package:flutter/material.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        appBar: AppBar(),
        title: 'Payment',
        hasCart: false,
      ),
      body: _buildBody(),
      hasDrawer: false,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Text('This is payment page'),
    );
  }
}
