import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/providers/checkout_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutRepository {
  final CheckoutProvider checkoutProvider;

  CheckoutRepository({required this.checkoutProvider});

  /// Update product checkout
  Future<dynamic> createStripePaymentSheet(Map<String, dynamic> body) async {
    try {
      final stripeResponse =
          await this.checkoutProvider.createStripePaymentSheet(body);
      return stripeResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> verifyPayment(
      {required int orderId, required PaymentIntent paymentIntent}) async {
    try {
      // All payment status names
      final paymentStatus = {
        PaymentIntentsStatus.Canceled: 'calceled',
        PaymentIntentsStatus.Processing: 'processing',
        PaymentIntentsStatus.RequiresAction: 'requiresAction',
        PaymentIntentsStatus.RequiresCapture: 'requiresCapture',
        PaymentIntentsStatus.RequiresConfirmation: 'requiresConfirmation',
        PaymentIntentsStatus.RequiresPaymentMethod: 'requiresPaymentMethod',
        PaymentIntentsStatus.Succeeded: 'succeeded',
      };
      // Create request payload
      Map<String, dynamic> requestBody = {
        'orderId': orderId,
        'ctx': {'accountId': accountId},
        'payment': {
          'paymentIntent': {
            'id': paymentIntent.id,
            'object': 'payment_intent',
            'amount': paymentIntent.amount,
            'canceled_at': paymentIntent.canceledAt,
            'cancellation_reason': null,
            'capture_method':
                paymentIntent.captureMethod == CaptureMethod.Manual
                    ? 'manual'
                    : 'automatic',
            'client_secret': paymentIntent.clientSecret,
            'confirmation_method':
                paymentIntent.confirmationMethod == ConfirmationMethod.Manual
                    ? 'manual'
                    : 'automatic',
            'created': paymentIntent.created,
            'currency': paymentIntent.currency,
            'description': paymentIntent.description,
            'last_payment_error': null,
            'livemode': paymentIntent.livemode,
            'next_action': null,
            'payment_method': paymentIntent.paymentMethodId,
            'payment_method_types': ['card'],
            'receipt_email': paymentIntent.receiptEmail,
            'setup_future_usage': null,
            'shipping': paymentIntent.shipping,
            'source': null,
            'status': paymentStatus[paymentIntent.status]
          }
        }
      };

      final response = await this.checkoutProvider.verifyPayment(requestBody);

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
