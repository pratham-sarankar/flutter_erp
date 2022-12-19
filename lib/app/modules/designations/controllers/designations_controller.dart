import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/designation_dialog.dart';
import 'package:get/get.dart';

class DesignationsController extends GetxController {
  late RxList<Designation> designations;
  late RxBool isLoading;
  late RxBool isRefreshing;

  @override
  void onInit() {
    isLoading = true.obs;
    isRefreshing = false.obs;
    fetchDesignations();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchDesignations() async {
    var designations = await DesignationRepository.instance.fetchAll();
    this.designations = RxList(designations);
    isLoading.value = false;
  }

  void createNewDesignation() async {
    Designation? designation = await showCupertinoDialog(
        context: Get.context!, builder: (context) => const DesignationDialog());
    if (designation == null) return;
    try {
      await DesignationRepository.instance.insertOne(designation);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void updateDesignation(Designation designation) async {
    Designation? updatedDesignation = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => DesignationDialog(designation: designation));
    if (updatedDesignation == null) return;
    try {
      await DesignationRepository.instance.updateOne(updatedDesignation);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void deleteDesignation(Designation designation) async {
    bool? sure = await showCupertinoDialog(
      context: Get.context!,
      builder: (context) => const ConfirmationDialog(
        message: "Are you sure, you want to delete the designation?",
      ),
    );
    if (!(sure ?? false)) return;
    try {
      await DesignationRepository.instance.deleteOne(designation);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  Future<void> refresh() async {
    if (isRefreshing.value) return;
    isRefreshing.value = true;
    designations.value = await DesignationRepository.instance.fetchAll();
    isRefreshing.value = false;
  }
}
