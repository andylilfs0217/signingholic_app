import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';

/// Base AppBar of the App
class AppAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;
  final bool hasCart;

  const AppAppBar({
    Key? key,
    required this.appBar,
    this.title = '',
    this.hasCart = true,
  }) : super(key: key);

  @override
  _AppAppBarState createState() => _AppAppBarState();
  @override
  Size get preferredSize => appBar.preferredSize;
}

class _AppAppBarState extends State<AppAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(widget.title),
      actions: [
        if (widget.hasCart) _buildShoppingCartIcon(),
      ],
    );
  }

  Widget _buildShoppingCartIcon() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        int qty = 0;
        if (state is LoginSuccessState) {
          // Add number of products in cart
          // qty += state.memberModel.productCart?.qtyTotal ?? 0; // Do not implement product yet
          // Add number of videos in cart
          qty += state.memberModel.videoCart?.items?.length ?? 0;
        }
        return IconButton(
            icon: Badge(
              child: Icon(Icons.shopping_cart),
              toAnimate: false,
              shape: BadgeShape.circle,
              badgeColor: Color(0xFFF16C5D),
              // If the member hasn't logged in, badge won't be shown
              badgeContent: Text(
                  state is LoginSuccessState ? qty.toString() : '',
                  style: TextStyle(color: Colors.white)),
              showBadge: state is LoginSuccessState && qty > 0,
            ),
            onPressed: () {
              AppNavigator.goTo(context, AppRoute.SHOPPING_CART, then: () {
                setState(() {});
              });
            });
      },
    );
  }
}
