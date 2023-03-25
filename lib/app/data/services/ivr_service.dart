import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class IVRService extends GetConnect {
  Future<void> initiateCall(String customerNumber) async {
    String executiveNumber = Get
        .find<AuthService>()
        .currentBranch
        .phoneNumber!;
    Map body = {
      "callFlowId":
      "TUMspyjWoYb+Ul8vp2khpgWZix3lECvaXcJtTQ78KKKprHaXDzvzesJo91alUK0Dpm/0pCLzW+2P8kW97mupRQ==",
      "customerId": "Gyanish_Fitness",
      "callType": "OUTBOUND",
      "callFlowConfiguration": {
        "initiateCall_1": {
          "callerId": "7411952280",
          "mergingStrategy": "SEQUENTIAL",
          "participants": [
            {"participantAddress": executiveNumber}
          ],
          "maxTime": 0
        },
        "addParticipant_1": {
          "mergingStrategy": "SEQUENTIAL",
          "maxTime": 0,
          "participants": [
            {"participantAddress": customerNumber}
          ]
        }
      }
    };
    Response response = await post(
      'https://openapi.airtel.in/gateway/airtel-xchange/v2/execute/workflow',
      body,
      headers: {
        'Authorization': 'Basic R3lhbmlzaF9GaXRuZXNzOkh5Sj1YQlR6dHVFUVQ5ODc=',
        'Accept-Encoding': 'gzip, deflate, br',
      },
      contentType: 'application/json',
    );
    (response.body);
    if (response.body[statusKey] == successStatusMessage) {
      Get.find<ToastService>().showErrorToast("Call initiated successfully");
    }
  }
}
