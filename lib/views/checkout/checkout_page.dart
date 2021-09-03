import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';
import 'package:singingholic_app/data/models/video/video_cart_item.dart';
import 'package:singingholic_app/data/models/video/video_item.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/utils/path_utils.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        appBar: AppBar(),
        title: 'Checkout',
        hasCart: false,
      ),
      body: _buildBody(),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.payment),
                label: Text('Pay'),
              ),
            ),
          ],
        ));
  }
}
