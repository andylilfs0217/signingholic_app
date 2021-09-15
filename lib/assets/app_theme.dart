import 'package:flutter/material.dart';

/// Different color of the App
class AppThemeColor {
  /// Theme color of the app
  static final ColorSwatch appPrimaryColor = Colors.orange;

  /// Secondary theme color of the app
  static final Color appSecondaryColor = Colors.black;

  /// Search bar color of the app
  static final Color? searchBarColor = Colors.grey[300];
}

/// Different widget size of the App
class AppThemeSize {
  /// Default horizontal margin/padding size of items
  static const defaultItemHorizontalPaddingSize = 10.0;

  /// Default vertical margin/padding size of items
  static const defaultItemVerticalPaddingSize = 10.0;

  /// Padding size of the entire screen
  static const screenPaddingSize = 10.0;

  /// Horizontal padding size of the drawer items
  static const appDrawerListTileHorizontalPaddingSize = 16.0;

  /// Vertical padding size of the drawer items
  static const appDrawerListTileVerticalPaddingSize = 20.0;

  /// Padding widget of the entire screen (left, top, bottom)
  static final screenPadding =
      EdgeInsets.fromLTRB(screenPaddingSize, 0, screenPaddingSize, 0);

  /// Padding widget of the drawer items
  static final appDrawerListTilePadding = EdgeInsets.symmetric(
      horizontal: appDrawerListTileHorizontalPaddingSize,
      vertical: appDrawerListTileVerticalPaddingSize);

  /// App border radius
  static const appBorderRadius = 5.0;
}

/// App default theme data
final ThemeData appThemeData = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
        .copyWith(secondary: AppThemeColor.appSecondaryColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(AppThemeSize.appBorderRadius)))),
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)));
