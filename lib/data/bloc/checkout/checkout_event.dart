part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class GetStripeBodyEvent extends CheckoutEvent {
  final Map<String, dynamic> body;

  const GetStripeBodyEvent({required this.body});

  @override
  List<Object> get props => [body];
}
