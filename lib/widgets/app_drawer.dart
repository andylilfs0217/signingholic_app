import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';
import 'package:singingholic_app/widgets/app_login_button.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              _buildDrawerHeader(),
              // _buildSearchBar(),
              _buildHomeTile(),
              _buildShopTile(),
              _buildOnlineClassTile(),
              _buildContactUsTile(),
              Divider(),
              if (state is LoginSuccessState) _buildMyOrderTile(),
              _buildSettingsTile(),
              if (state is LoginSuccessState) ...[
                Divider(),
                _buildLogoutTile()
              ],
            ],
          ),
        );
      },
    );
  }

  /// Create Drawer header
  Widget _buildDrawerHeader() {
    return DrawerHeader(
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return state is LoginSuccessState
              ? _buildMemberProfile()
              : _buildLoginButton();
        },
      ),
    );
  }

  /// Create Login button in the drawer header
  Widget _buildLoginButton() {
    return Center(
      child: AppLoginButton(),
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
      enabled: false, // TODO: Enable the listTile
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
      enabled: false, // TODO: Enable the listTile
    );
  }

  /// Create Contact Us Tile
  Widget _buildContactUsTile() {
    return AppDrawerListTile(
      title: 'Contact Us',
      onTap: () {
        AppNavigator.drawerGoTo(context, AppRoute.CONTACT_US);
      },
    );
  }

  /// Create Settings Tile
  Widget _buildSettingsTile() {
    return AppDrawerListTile(
      title: 'Settings',
      onTap: () {
        AppNavigator.drawerGoTo(context, AppRoute.SETTINGS);
      },
    );
  }

  /// Build member profile in the drawer header after login
  Widget _buildMemberProfile() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccessState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                      text: state.memberModel.name ?? '', // Member name
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        if (state.memberModel.tier != null &&
                            state.memberModel.tier!.name != null)
                          TextSpan(
                              text:
                                  ' (${state.memberModel.tier!.name!})') // Member tier
                      ],
                    )),
                  ),
                  // Details button
                  TextButton(
                      onPressed: () {
                        print('Go to details');
                      },
                      child: Text('Details'))
                ],
              ),
              SizedBox(height: AppThemeSize.defaultItemHorizontalPaddingSize),
              // Member email
              Text(state.memberModel.email ?? '',
                  style: Theme.of(context).textTheme.bodyText2),
              SizedBox(height: AppThemeSize.defaultItemHorizontalPaddingSize),
              // Member points
              Text('Points: ${state.memberModel.points ?? 0}',
                  style: Theme.of(context).textTheme.bodyText2),
            ],
          );
        }
        return Center(child: Text('No data'));
      },
    );
  }

  /// My order drawer tile after login success
  Widget _buildMyOrderTile() {
    return AppDrawerListTile(
      title: 'My Order',
      onTap: () {
        // TODO: Implement navigation to My order page
        print('Go to my order page');
      },
      enabled: false, // TODO: Enable the listTile
    );
  }

  ///
  Widget _buildLogoutTile() {
    return AppDrawerListTile(
      title: 'Logout',
      onTap: () {
        context.read<LoginBloc>().add(LogoutEvent());
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

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the current [Theme] and the [onTap] and [onLongPress] callbacks are inoperative.
  final bool enabled;

  /// Create App Drawer List Tile
  const AppDrawerListTile(
      {Key? key,
      this.title = '',
      this.onTap,
      this.selected = false,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      selected: selected,
      enabled: enabled,
    );
  }
}
