import 'package:flutter_erp/app/data/models/payment.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:resource_manager/resource_manager.dart';

class PaymentRepository extends Repository<Payment> {
  PaymentRepository() : super(path: "/payment");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Payment get empty =>
      Payment(branchId: Get.find<AuthService>().currentBranch.id);

  @override
  Future<List<Payment>> fetch(
      {int limit = 100,
      int offset = 0,
      Map<String, dynamic> queries = const {}}) {
    var updatedQueries = {
      ...queries,
      "branch_id": Get.find<AuthService>().currentBranch.id,
    };
    return super.fetch(limit: limit, offset: offset, queries: updatedQueries);
  }

  @override
  Future<void> insert(Payment value) async {
    var options = {
      'key': "rzp_test_BPssz4PDR9fJ4B",
      'amount': value.amount,
      'name': value.customer?.name,
      'description': value.description,
      'prefill': {
        'contact': value.customer?.phoneNumber,
        'email': value.customer?.email,
      },
    };
    checkout(options);
  }

  Future checkout(Map<String, dynamic> options) async {
    var razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Success $response");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error $response");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External wallet $response");
  }
}
