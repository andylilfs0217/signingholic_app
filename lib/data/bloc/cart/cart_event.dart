part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

// class GetProductCartDetailsEvent extends CartEvent {
//   /// Product cart model
//   final ProductCartModel productCartModel;

//   GetProductCartDetailsEvent({required this.productCartModel});
// }

class GetVideoCartDetailsEvent extends CartEvent {
  /// Video cart model
  final VideoCartModel videoCartModel;

  GetVideoCartDetailsEvent({required this.videoCartModel});

  @override
  List<Object> get props => [videoCartModel];
}

class UpdateVideoCartEvent extends CartEvent {
  /// Video item
  final VideoCartModel videoCartModel;

  UpdateVideoCartEvent({required this.videoCartModel});

  @override
  List<Object> get props => [videoCartModel];
}
