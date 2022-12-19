import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

//TODO: Show overlay instead of Fluttertoast
class ToastService extends GetxService {
  Future<ToastService> init() async {
    return this;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
    );
  }
}
