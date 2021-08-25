import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';

/// Base AppBar of the App
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;
  final bool hasCart;

  const AppAppBar(
      {Key? key, required this.appBar, this.title = '', this.hasCart = true})
      : super(key: key);

  @override
  Size get preferredSize => appBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actions: [if (hasCart) _buildShoppingCartIcon()],
    );
  }

  Widget _buildShoppingCartIcon() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        int qty = 0;
        if (state is LoginSuccessState &&
            state.memberModel.productCart != null) {
          var productCart = jsonDecode(state.memberModel.productCart!);
          if (productCart['qtyTotal'] != null) {
            qty = productCart['qtyTotal'];
          }
        }
        return IconButton(
            icon: Badge(
              child: Icon(Icons.shopping_cart),
              toAnimate: false,
              shape: BadgeShape.circle,
              badgeColor: AppThemeColor.appSecondaryColor,
              badgeContent:
                  Text(qty.toString(), style: TextStyle(color: Colors.white)),
              showBadge: state is LoginSuccessState,
            ),
            onPressed: () {
              // TODO: Implement navigation to shopping cart
              print('Go to shopping cart page');
              AppNavigator.goTo(context, AppRoute.SHOPPING_CART);
            });
      },
    );
  }
}
