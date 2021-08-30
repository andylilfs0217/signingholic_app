part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}

class GettingCartProductState extends CartState {}

class GetCartProductSuccessState extends CartState {
  /// Product Item
  final List<ProductItemModel> productItems;

  GetCartProductSuccessState({required this.productItems});
}

class GetCartProductFailedState extends CartState {}

class GettingCartVideoState extends CartState {}

class GetCartVideoSuccessState extends CartState {
  /// Video item
  final List<VideoItemModel> videoItems;

  GetCartVideoSuccessState({required this.videoItems});
}

class GetCartVideoFailedState extends CartState {}
