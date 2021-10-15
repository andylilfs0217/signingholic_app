import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:singingholic_app/data/repo/checkout_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutRepository checkoutRepository;
  CheckoutBloc({required this.checkoutRepository})
      : super(CheckoutInitialState());

  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if (event is GetStripeBodyEvent) {
      try {
        yield GettingStripePaymentState();

        // 1. create payment intent on the server
        final paymentSheetData = await _createTestPaymentSheet(event.body);

        // 2. initialize the payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            // Main params
            paymentIntentClientSecret: paymentSheetData['client_secret'],
            merchantDisplayName: 'Singingholic',
            // Customer params
            // customerId: paymentSheetData['customer'],
            // customerEphemeralKeySecret: paymentSheetData['ephemeralKey'],
            // Extra params
            applePay: false,
            googlePay: false,
            style: ThemeMode.dark,
            testEnv: true,
            merchantCountryCode: 'HK',
          ),
        );

        yield PresentStripePaymentSheetState();
        // 3. display the payment sheet.
        await Stripe.instance.presentPaymentSheet();

        // TODO: POST https://test.thinkshops.io/public/ec/order/payment/verify
        final paymentIntent = await Stripe.instance
            .retrievePaymentIntent(paymentSheetData['client_secret']);

        final order = await this.checkoutRepository.verifyPayment(
            orderId: paymentSheetData['orderId'], paymentIntent: paymentIntent);

        yield FinishPaymentState();
      } catch (e) {
        if (e is StripeException) {
          print('Error from Stripe: ${e.error.localizedMessage}');
          yield GetStripePaymentFailState(
              errorMessage: e.error.localizedMessage ?? 'Error');
        } else {
          print('Error: $e');
          // yield GetStripePaymentFailState();
          yield PaymentFailState(errorMessage: e.toString());
        }
        rethrow;
      }
    }
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet(
      Map<String, dynamic> body) async {
    final response = await checkoutRepository.createStripePaymentSheet(body);
    final responseBody = response['payload'];
    return responseBody;
  }
}
