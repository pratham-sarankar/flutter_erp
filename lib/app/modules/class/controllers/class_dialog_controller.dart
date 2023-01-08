import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:flutter_erp/app/data/services/file_service.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class ClassDialogController extends GetxController {
  late GlobalKey<FormState> formKey;
  late Class model;
  Uint8List? image;
  late RxBool isLoading;

  @override
  void onInit() {
    model = Get.arguments ?? Class();
    print(model);
    isLoading = model.hasPhoto.obs;
    formKey = GlobalKey<FormState>();
    initImage();
    super.onInit();
  }

  void initImage() async {
    if (!model.hasPhoto) return;
    image = await Get.find<FileService>()
        .dataFromNetworkImage(model.getPhotoUrl()!);
    isLoading.value = false;
  }

  void updateImage() async {
    var result = await FilePicker.platform.pickFiles(
      dialogTitle: "Pick Image",
      allowCompression: true,
      allowMultiple: false,
    );
    image = result?.files.first.bytes;
    if (image == null) return;
    isLoading.value = true;
    try {
      String key = await FileRepository.instance.imageUploader(image!);
      model.photoUrl = key;
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    isLoading.value = false;
  }

  void save() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      Get.back(result: model);
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
