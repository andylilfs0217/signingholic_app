import 'package:flutter/material.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildSearchBar(),
          _buildHomeTile(),
          _buildShopTile(),
          _buildOnlineClassTile(),
          _buildContactUsTile(),
          _buildSettingsTile(),
        ],
      ),
    );
  }

  /// Create Drawer header
  Widget _buildDrawerHeader() {
    return DrawerHeader(
      child: _buildLoginButton(),
    );
  }

  /// Craete Login button in the drawer header
  Widget _buildLoginButton() {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          // TODO: implement login or sign up function
          print('Login/Sign up');
          AppNavigator.drawerGoTo(context, AppRoute.LOGIN);
        },
        child: const Text('Login/Sign up'),
      ),
    );
  }

  /// Create Search bar
  Widget _buildSearchBar() {
    return Padding(
      padding: AppThemeSize.appDrawerListTilePadding,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppThemeColor.searchBarColor,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        ),
      ),
    );
  }

  /// Create Home Tile
  Widget _buildHomeTile() {
    return AppDrawerListTile(
      title: 'Home',
      onTap: () {
        AppNavigator.drawerGoTo(context, AppRoute.HOME);
      },
    );
  }

  /// Create Shop Tile
  Widget _buildShopTile() {
    return AppDrawerListTile(
      title: 'Shop',
      onTap: () {
        // TODO: Implement navigation to Shop page
        print('Go to Shop page');
      },
    );
  }

  /// Create Online Class Tile
  Widget _buildOnlineClassTile() {
    return AppDrawerListTile(
      title: 'Online Class',
      onTap: () {
        // TODO: Implement navigation to Online Class page
        print('Go to Online Class page');
      },
    );
  }

  /// Create Contact Us Tile
  Widget _buildContactUsTile() {
    return AppDrawerListTile(
      title: 'Contact Us',
      onTap: () {
        // TODO: Implement navigation to Contact Us page
        print('Go to Contact Us page');
      },
    );
  }

  /// Create Settings Tile
  Widget _buildSettingsTile() {
    return AppDrawerListTile(
      title: 'Settings',
      onTap: () {
        // TODO: Implement navigation to Settings page
        print('Go to Settings page');
      },
    );
  }
}

/// App Drawer List Tile
class AppDrawerListTile extends StatelessWidget {
  /// Title of the List Tile
  final String title;

  /// Action of List Tile tap
  final Function()? onTap;

  /// Show if selected
  final bool selected;

  /// Create App Drawer List Tile
  const AppDrawerListTile(
      {Key? key, this.title = '', this.onTap, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      selected: selected,
    );
  }
}
