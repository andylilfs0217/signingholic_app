import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:singingholic_app/assets/app_theme.dart';

/// Shopping cart item
class ShoppingCartProduct extends StatefulWidget {
  const ShoppingCartProduct({Key? key}) : super(key: key);

  @override
  _ShoppingCartProductState createState() => _ShoppingCartProductState();
}

class _ShoppingCartProductState extends State<ShoppingCartProduct> {
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
        imageUrl: 'https://picsum.photos/300/300',
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
      'iPhone 13',
      style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeFactor: 1.5),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  /// Create product options text
  Widget _buildOptions() {
    return Expanded(
      child: Text(
        'Model: Pro Max',
        style: Theme.of(context).textTheme.bodyText2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Create product price text
  Widget _buildPrice() {
    return Expanded(
      child: Text(
        'Price: \$9999.99',
        style: Theme.of(context).textTheme.bodyText2,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  /// Create item quantity selection
  Widget _buildQty() {
    return Row(
      children: [
        // Minus
        InkWell(
          onTap: () {
            print('Minus');
          },
          child: Container(
              width: 30,
              child:
                  AspectRatio(aspectRatio: 1 / 1, child: Icon(Icons.remove))),
        ),
        // Quantity text field
        Container(
          width: 60,
          child: TextField(),
        ),
        // Add
        InkWell(
          onTap: () {
            print('Add');
          },
          child: Container(
              width: 30,
              child: AspectRatio(aspectRatio: 1 / 1, child: Icon(Icons.add))),
        ),
      ],
    );
  }
}
