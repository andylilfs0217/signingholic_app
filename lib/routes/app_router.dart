import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singingholic_app/data/models/video/video_item.dart';
import 'package:singingholic_app/routes/app_arguments.dart';
import 'package:singingholic_app/views/checkout/checkout_page.dart';
import 'package:singingholic_app/views/error/page_not_found_page.dart';
import 'package:singingholic_app/views/home/home_page.dart';
import 'package:singingholic_app/views/login/login_page.dart';
import 'package:singingholic_app/views/shopping_cart/shopping_cart_page.dart';
import 'package:singingholic_app/views/upload/upload_page.dart';
import 'package:singingholic_app/views/video/video_list_page.dart';
import 'package:singingholic_app/views/video/video_page.dart';

class AppRoute {
  static const INIT = '/';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const VIDEO = '/video';
  static const UPLOAD = '/upload';
  static const VIDEO_LIST = '/video-list';
  static const SHOPPING_CART = '/shopping_cart';
  static const CHECKOUT = '/checkout';
}

class AppRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.INIT:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoute.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRoute.HOME:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoute.VIDEO:
        final args = settings.arguments as VideoArguments;
        return MaterialPageRoute(builder: (_) => VideoPage(id: args.id));
      case AppRoute.UPLOAD:
        return MaterialPageRoute(builder: (_) => UploadPage());
      case AppRoute.VIDEO_LIST:
        final args = settings.arguments as VideoListArguments;
        return MaterialPageRoute(
            builder: (_) => VideoListPage(title: args.title));
      case AppRoute.SHOPPING_CART:
        return MaterialPageRoute(builder: (_) => ShoppingCartPage());
      case AppRoute.CHECKOUT:
        final args = settings.arguments as CheckoutArguments;
        return MaterialPageRoute(
            builder: (_) => CheckoutPage(
                  videoItems: args.videoItems,
                  videoCart: args.videoCart,
                ));
      default:
        return MaterialPageRoute(builder: (_) => PageNotFoundPage());
    }
  }
}
