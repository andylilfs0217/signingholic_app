import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:singingholic_app/data/models/product/product_cart.dart';
import 'package:singingholic_app/data/models/product/product_item.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';
import 'package:singingholic_app/data/models/video/video_item.dart';
import 'package:singingholic_app/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  /// Cart repository
  final CartRepository cartRepository;
  CartBloc({required this.cartRepository}) : super(CartInitialState());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // if (event is GetProductCartDetailsEvent) {
    //   try {
    //     yield GettingCartProductState();
    //     var response =
    //         await cartRepository.updateProductCart(event.productCartModel);
    //     if (response['succeed'] != null && response['succeed']) {
    //       List<ProductItemModel> productItems = response['payload']['products']
    //           .map<ProductItemModel>((e) => ProductItemModel.fromJson(e))
    //           .toList();
    //       yield GetCartProductSuccessState(productItems: productItems);
    //     } else {
    //       yield GetCartProductFailedState();
    //     }
    //   } catch (e) {
    //     yield GetCartProductFailedState();
    //     throw Exception(e);
    //   }
    // }
    if (event is GetVideoCartDetailsEvent) {
      try {
        yield GettingCartVideoState();
        var response =
            await cartRepository.updateVideoCart(event.videoCartModel);
        if (response['succeed'] != null && response['succeed']) {
          List<VideoItemModel> videoItems = response['payload']?['videos']
                  ?.map<VideoItemModel>((e) => VideoItemModel.fromJson(e))
                  .toList() ??
              [];
          yield GetCartVideoSuccessState(videoItems: videoItems);
        } else {
          yield GetCartVideoFailedState();
        }
      } catch (e) {
        yield GetCartVideoFailedState();
        throw Exception(e);
      }
    }
    if (event is UpdateVideoCartEvent) {
      try {
        yield CartInitialState();
        await cartRepository.changeVideoCart(event.videoCartModel);
      } catch (e) {
        throw Exception(e);
      }
    }
  }
}
