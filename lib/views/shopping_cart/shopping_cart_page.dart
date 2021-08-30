import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/cart/cart_bloc.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/data/models/product/product_cart.dart';
import 'package:singingholic_app/data/models/product/product_cart_item.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';
import 'package:singingholic_app/data/models/video/video_cart_item.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';
import 'package:singingholic_app/utils/path_utils.dart';
import 'package:singingholic_app/views/shopping_cart/shopping_cart_product.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_login_button.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  /// Product item list
  // ProductCartModel? productCart;

  /// Video item list
  VideoCartModel? videoCart;

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
          // productCart = state.memberModel.productCart!;
          videoCart = state.memberModel.videoCart!;
          // context
          //     .read<CartBloc>()
          //     .add(GetProductCartDetailsEvent(productCartModel: productCart!));
          context
              .read<CartBloc>()
              .add(GetVideoCartDetailsEvent(videoCartModel: videoCart!));

          // If the member has logged in, show the shopping cart
          return videoCart!.items!.isNotEmpty
              ? Column(
                  children: [
                    _buildProducts(),
                    Divider(),
                    _buildSummary(),
                    SizedBox(height: AppThemeSize.screenPaddingSize),
                  ],
                )
              : _buildVideoCartEmpty();
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
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginSuccessState) {
              return Column(
                children: [
                  // if ((state.memberModel.productCart?.items?.length ?? 0) != 0)
                  //   _buildProductCart(),
                  if ((state.memberModel.videoCart?.items?.length ?? 0) != 0)
                    _buildVideoCart(),
                ],
              );
            } else {
              return AppCircularLoading();
            }
          },
        ),
      ),
    ));
  }

  /// Show shopping cart summary
  Widget _buildSummary() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        num subTotal =
            // (productCart?.itemTotal ?? 0) +  // Do not implement product yet
            (videoCart?.itemTotal ?? 0);
        return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppThemeSize.screenPaddingSize),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Subtotal:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text(
                      '\$${subTotal.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      AppNavigator.goTo(context, AppRoute.CHECKOUT);
                    },
                    icon: Icon(Icons.shopping_basket),
                    label: Text('Checkout'),
                  ),
                ),
              ],
            ));
      },
    );
  }

  // Widget _buildProductCart() {
  //   return BlocBuilder<CartBloc, CartState>(
  //     builder: (context, state) {
  //       List productCartItems = [];
  //       if (state is GetCartProductSuccessState) {
  //         for (var i = 0; i < productCart!.items!.length; i++) {
  //           productCartItems.add(ShoppingCartProduct(
  //             qty: productCart!.items![i].qty ?? 1,
  //             price: productCart!.items![i].unit ?? 0,
  //             discount: productCart!.items![i].discount,
  //             discountedPrice: productCart!.items![i].unitDiscounted,
  //             name: state.productItems[i].name ?? '',
  //             imageUrl: PathUtils.getSiteImage(
  //                 accountId, state.productItems[i].imagePaths?[0]),
  //           ));
  //         }
  //       }

  //       return Column(
  //         children: [
  //           Text('Product'),
  //           ...productCartItems,
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildVideoCart() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        List videoCartItems = [];
        if (state is GetCartVideoSuccessState) {
          for (var i = 0; i < videoCart!.items!.length; i++) {
            videoCartItems.add(ShoppingCartProduct(
              key: Key('video_$i'),
              qty: videoCart!.items![i].qty ?? 1,
              price: videoCart!.items![i].unit ?? 0,
              discount: videoCart!.items![i].discount,
              discountedPrice: videoCart!.items![i].unitDiscounted,
              name: state.videoItems[i].name ?? '',
              imageUrl: PathUtils.getImagePathWithId(accountId, 'video',
                  state.videoItems[i].id, state.videoItems[i].imagePaths?[0]),
              isVideo: true,
              onDelete: () {
                setState(() {
                  videoCart!.items!.removeAt(i);
                  videoCartItems.removeAt(i);
                  context
                      .read<CartBloc>()
                      .add(UpdateVideoCartEvent(videoCartModel: videoCart!));
                });
              },
            ));
          }
        }

        return Column(
          children: [
            Text(
              'Videos',
              style: Theme.of(context).textTheme.headline5,
            ),
            ...videoCartItems,
          ],
        );
      },
    );
  }

  Widget _buildVideoCartEmpty() {
    return Center(
      child: Text('Your shopping cart is empty. Go shopping!'),
    );
  }
}
