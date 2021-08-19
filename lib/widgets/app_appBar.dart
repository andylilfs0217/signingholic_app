import 'package:flutter/material.dart';

/// Base AppBar of the App
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;

  const AppAppBar({Key? key, required this.appBar, this.title = ''})
      : super(key: key);

  @override
  Size get preferredSize => appBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actions: [_buildShoppingCartIcon()],
    );
  }

  Widget _buildShoppingCartIcon() {
    return IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          // TODO: Implement navigation to shopping cart
          print('Go to shopping cart page');
        });
  }
}
