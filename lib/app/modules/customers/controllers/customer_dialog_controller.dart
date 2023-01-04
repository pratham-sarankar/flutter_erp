import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:flutter_erp/app/data/services/file_service.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:get/get.dart';

class CustomerDialogController extends GetxController {
  late GlobalKey<FormState> formKey;
  late Customer customer;
  Uint8List? image;
  late RxBool isLoading;

  @override
  void onInit() {
    customer = Get.arguments ?? Customer();
    isLoading = customer.hasPhoto.obs;
    formKey = GlobalKey<FormState>();
    initImage();
    super.onInit();
  }

  void initImage() async {
    if (!customer.hasPhoto) return;
    image = await Get.find<FileService>()
        .dataFromNetworkImage(customer.getPhotoUrl()!);
    isLoading.value = false;
  }

  void updateImage() async {
    var result = await FilePicker.platform.pickFiles(
      dialogTitle: "Hello world",
      allowCompression: true,
      allowMultiple: false,
    );
    image = result?.files.first.bytes;
    if (image == null) return;
    isLoading.value = true;
    try {
      String key = await FileRepository.instance.uploadFile(image!);
      customer.photoUrl = key;
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    isLoading.value = false;
  }

  void save() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      Get.back(result: customer);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
