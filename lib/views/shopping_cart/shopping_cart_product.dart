import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:singingholic_app/assets/app_theme.dart';

/// Shopping cart item
class ShoppingCartProduct extends StatefulWidget {
  /// Image Url of the product
  final String imageUrl;

  /// Name of the product
  final String name;

  /// Options of the product
  final String options;

  /// Unit price of the product
  final num price;

  /// Discounted unit price of the product
  final num? discountedPrice;

  /// Total discount of the product
  final num? discount;

  /// Quantity of the product in cart
  final int qty;

  const ShoppingCartProduct({
    Key? key,
    this.imageUrl =
        'https://picsum.photos/300/300', // TODO: Change default product image
    this.name = '',
    this.options = '',
    this.price = 0,
    this.qty = 1,
    this.discountedPrice,
    this.discount,
  }) : super(key: key);

  @override
  _ShoppingCartProductState createState() => _ShoppingCartProductState();
}

enum CounterMode { increase, decrease }

class _ShoppingCartProductState extends State<ShoppingCartProduct> {
  int count = 1;
  bool _buttonPressed = false;
  bool _loopActive = false;

  /// Change number of items
  void _changeCounterWhilePressed(CounterMode counterMode) async {
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      setState(() {
        if (counterMode == CounterMode.increase) count++;
        if (counterMode == CounterMode.decrease && count > 1) count--;
      });

      // wait a bit
      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;
  }

  @override
  void initState() {
    super.initState();
    // Override item quantity
    count = widget.qty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(
          vertical: AppThemeSize.appDrawerListTileHorizontalPaddingSize / 4),
      color: Colors.white,
      // Slidable item for deleting an item from cart
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            _buildProductDetail(),
          ],
        ),
        secondaryActions: [
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => print('Delete'),
          ),
        ],
      ),
    );
  }

  /// Build Product image
  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
      ),
    );
  }

  /// Build product details
  Widget _buildProductDetail() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildName(),
            _buildOptions(),
            Row(
              children: [
                _buildPrice(),
                _buildQty(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Create product name text
  Widget _buildName() {
    return Text(
      widget.name,
      style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeFactor: 1.5),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  /// Create product options text
  Widget _buildOptions() {
    return Expanded(
      child: Text(
        widget.options,
        style: Theme.of(context).textTheme.bodyText2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Create product price text
  Widget _buildPrice() {
    return Expanded(
      child: RichText(
        text: TextSpan(
            text: '\$${widget.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyText2!.apply(
                decoration: (widget.discountedPrice != null &&
                        widget.discount != null &&
                        widget.discount != 0)
                    ? TextDecoration.lineThrough
                    : null),
            children: [
              if (widget.discountedPrice != null &&
                  widget.discount != null &&
                  widget.discount != 0)
                TextSpan(
                    text: ' \$${widget.discountedPrice!.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyText1),
            ]),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  /// Create item quantity selection
  Widget _buildQty() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Minus
        GestureDetector(
          onTap: () {
            setState(() {
              if (count > 1) count--;
            });
          },
          onLongPressStart: (details) {
            _buttonPressed = true;
            _changeCounterWhilePressed(CounterMode.decrease);
          },
          onLongPressEnd: (details) {
            _buttonPressed = false;
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: count == 1 ? Colors.grey.shade300 : Colors.black,
              ),
              width: 30,
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ))),
        ),
        // Quantity text field
        Container(
          width: 50,
          alignment: Alignment.center,
          child: Text(count.toString()),
        ),
        // Add
        GestureDetector(
          onTap: () {
            setState(() {
              count++;
            });
          },
          onLongPressStart: (details) {
            _buttonPressed = true;
            _changeCounterWhilePressed(CounterMode.increase);
          },
          onLongPressEnd: (details) {
            _buttonPressed = false;
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppThemeColor.appSecondaryColor,
              ),
              width: 30,
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ))),
        ),
      ],
    );
  }
}
