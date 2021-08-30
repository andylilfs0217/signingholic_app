import 'package:singingholic_app/data/models/product/product_cart.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';
import 'package:singingholic_app/providers/cart_provider.dart';

class CartRepository {
  final CartProvider cartProvider;

  CartRepository({required this.cartProvider});

  /// Update product cart
  Future<dynamic> updateProductCart(ProductCartModel productCartModel) async {
    try {
      final videoListModel =
          await this.cartProvider.getProductCartDetails(productCartModel);
      return videoListModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Update product cart
  Future<dynamic> updateVideoCart(VideoCartModel videoCartModel) async {
    try {
      final videoListModel =
          await this.cartProvider.getVideoCartDetails(videoCartModel);
      return videoListModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
