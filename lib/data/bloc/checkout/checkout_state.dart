part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitialState extends CheckoutState {}

class GettingStripePaymentState extends CheckoutState {}

class GetStripePaymentSuccessState extends CheckoutState {}

class PresentStripePaymentSheetState extends CheckoutState {}

class FinishPaymentState extends CheckoutState {}

class PaymentErrorState extends CheckoutState {
  /// Error message
  final String errorMessage;

  const PaymentErrorState({required this.errorMessage}) : super();

  @override
  List<Object> get props => [errorMessage];
}

class GetStripePaymentFailState extends PaymentErrorState {
  /// Error message
  final String errorMessage;

  const GetStripePaymentFailState({required this.errorMessage})
      : super(errorMessage: errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class PaymentFailState extends PaymentErrorState {
  /// Error message
  final String errorMessage;

  const PaymentFailState({required this.errorMessage})
      : super(errorMessage: errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
