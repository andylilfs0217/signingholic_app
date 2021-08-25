import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';
import 'package:singingholic_app/views/shopping_cart/shopping_cart_product.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_login_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        appBar: AppBar(),
        title: 'Shopping Cart',
        hasCart: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccessState) {
          // If the member has logged in, show the shopping cart
          return Column(
            children: [
              _buildProducts(),
              Divider(),
              _buildSummary(),
              SizedBox(height: AppThemeSize.screenPaddingSize),
            ],
          );
        } else {
          // If the member hasn't logged in, tell him to log in
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text('You haven\'t logged in yet. Please login.'),
                AppLoginButton(),
              ]));
        }
      },
    );
  }

  /// Show all shopping cart products
  Widget _buildProducts() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.fromLTRB(AppThemeSize.screenPaddingSize,
          AppThemeSize.screenPaddingSize, AppThemeSize.screenPaddingSize, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ShoppingCartProduct(),
            ShoppingCartProduct(),
            ShoppingCartProduct(),
          ],
        ),
      ),
    ));
  }

  /// Show shopping cart summary
  Widget _buildSummary() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppThemeSize.screenPaddingSize),
      child: Row(
        children: [
          Expanded(child: Container()),
          // Checkout button
          ElevatedButton(
              onPressed: () {
                print('Check out');
              },
              child: Text('Checkout')),
        ],
      ),
    );
  }
}
