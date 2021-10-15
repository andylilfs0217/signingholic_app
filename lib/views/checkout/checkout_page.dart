import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/cart/cart_bloc.dart';
import 'package:singingholic_app/data/bloc/checkout/checkout_bloc.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';
import 'package:singingholic_app/data/models/video/video_cart_item.dart';
import 'package:singingholic_app/data/models/video/video_item.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';
import 'package:singingholic_app/utils/path_utils.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_dialog.dart';

class CheckoutPage extends StatefulWidget {
  final List<VideoItemModel> videoItems;
  final VideoCartModel videoCart;

  const CheckoutPage(
      {Key? key, required this.videoItems, required this.videoCart})
      : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late MemberModel memberModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccessState) {
          memberModel = state.memberModel;
        }
        return Scaffold(
          appBar: AppAppBar(
            appBar: AppBar(),
            title: 'Checkout',
            hasCart: false,
          ),
          body: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildProducts(),
        Divider(),
        _buildSummary(),
        SizedBox(height: AppThemeSize.screenPaddingSize),
      ],
    );
  }

  /// Show all shopping cart products
  Widget _buildProducts() {
    var widgetList = <Widget>[];
    for (var i = 0; i < widget.videoItems.length; i++) {
      widgetList.add(
          _buildVideoItem(widget.videoItems[i], widget.videoCart.items![i]));
    }
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(AppThemeSize.screenPaddingSize,
            AppThemeSize.screenPaddingSize, AppThemeSize.screenPaddingSize, 0),
        child: SingleChildScrollView(
          child: Column(
            children: widgetList,
          ),
        ),
      ),
    );
  }

  /// Create video item widget
  Widget _buildVideoItem(
      VideoItemModel videoItem, VideoCartItemModel videoCartItem) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(
          vertical: AppThemeSize.appDrawerListTileHorizontalPaddingSize / 4),
      color: Colors.white,
      // Slidable item for deleting an item from cart
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(PathUtils.getImagePathWithId(
              accountId, 'video', videoItem.id, videoItem.imagePaths![0])),
          _buildProductDetail(videoItem, videoCartItem),
        ],
      ),
    );
  }

  /// Build Product image
  Widget _buildImage(String imageUrl) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => AppCircularLoading(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  /// Build product details
  Widget _buildProductDetail(
      VideoItemModel videoItem, VideoCartItemModel videoCartItem) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildName(videoItem.name!),
            _buildOptions(''),
            Row(
              children: [
                _buildPrice(videoItem.price!),
                _buildQty(videoCartItem.qty ?? 1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Create product name text
  Widget _buildName(String name) {
    return Text(
      name,
      style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeFactor: 1.5),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  /// Create product options text
  Widget _buildOptions(String options) {
    return Expanded(
      child: Text(
        options,
        style: Theme.of(context).textTheme.bodyText2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Create product price text
  Widget _buildPrice(num price) {
    return Expanded(
        child: Text(
      '\$${price.toStringAsFixed(2)}',
      style: Theme.of(context).textTheme.bodyText2,
    ));
  }

  /// Create item quantity selection
  Widget _buildQty(int count) {
    return Container(
      alignment: Alignment.center,
      child: Text("x${count.toString()}"),
    );
  }

  /// Show shopping cart summary
  Widget _buildSummary() {
    num subTotal = 0;
    widget.videoItems.forEach((element) {
      subTotal += element.price ?? 0;
    });
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppThemeSize.screenPaddingSize),
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
            _buildPayButton(),
          ],
        ));
  }

  Widget _buildPayButton() {
    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is FinishPaymentState) {
          // Clear shopping cart
          final emptyVideoCart =
              VideoCartModel(items: [], gifts: [], itemTotal: 0, usePoints: 0);
          context
              .read<CartBloc>()
              .add(UpdateVideoCartEvent(videoCartModel: emptyVideoCart));
          context
              .read<LoginBloc>()
              .add(LoginUpdateVideoCartEvent(videoCartModel: emptyVideoCart));
          // Pop up payment success message
          showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AppDialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline),
                      Text('Payment confirm')
                    ],
                  ),
                );
              });
          // Go back to Home page after 1 second
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
            AppNavigator.goTo(context, AppRoute.HOME);
          });
        } else if (state is PaymentErrorState) {
          // Tell users that the payment is failed
          final snackBar = SnackBar(
            content: Text(state.errorMessage),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
              textColor: AppThemeColor.appPrimaryColor,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        if (state is CheckoutInitialState ||
            state is FinishPaymentState ||
            state is GetStripePaymentFailState ||
            state is PaymentFailState) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                _initStripe();
              },
              icon: Icon(Icons.payment),
              label: Text('Pay'),
            ),
          );
        } else {
          return AppCircularLoading();
        }
      },
    );
  }

  void _initStripe() {
    // Call Stripe payment
    Map<String, dynamic> body = {
      'ctx': {'accountId': accountId},
      'member': memberModel.toJson(),
      'body': {
        'cart': widget.videoCart.toJson(),
        'details': {
          'method': 'stripe',
          'mode': 'full',
          'logisticsLocation': null,
          'logisticsMethod': null,
          'form': memberModel.toJson()
        },
        'miniSite': null,
      }
    };
    body['body']['details']['form']['_data'] = {
      'name': memberModel.name,
      'email': memberModel.email,
      'mobile': memberModel.mobile,
      'address': memberModel.address,
      'birthday': memberModel.birthday
    };
    body['body']['cart'] = {
      ...body['body']['cart'] as Map<String, dynamic>,
      ...{'shippingTotal': 0, 'shippingDiscounted': 0, 'type': 'video'}
    };
    context.read<CheckoutBloc>().add(GetStripeBodyEvent(body: body));
  }
}
