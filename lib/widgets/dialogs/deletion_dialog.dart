import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_manager/data/data.dart';

class DeletionDialog extends StatelessWidget {
  const DeletionDialog({Key? key, required this.onDelete}) : super(key: key);
  final Future<bool> Function() onDelete;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DeletionController(onDelete),
      builder: (controller) {
        return Dialog(
          backgroundColor: Colors.transparent,
          alignment: Alignment.center,
          child: Container(
            width: Get.width*0.4,
            decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(maxHeight: Get.height * 0.9),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Confirm",
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height:20),
                const Text("Are you sure you want to perform this action?"),
                _footer(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _footer(DeletionController controller) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Obx(
                      () => Text(
                    controller.error.value,
                    style: TextStyle(
                      color: Get.theme.colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(
                        result: false,
                      );
                    },
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 18, horizontal: 35),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      fixedSize: const MaterialStatePropertyAll(Size(140, 40)),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.confirm();
                    },
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 18, horizontal: 45),
                      ),
                      fixedSize: const MaterialStatePropertyAll(Size(140, 40)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    child: Obx(
                          () => controller.isLoading.value
                          ? const CupertinoActivityIndicator(
                          color: Colors.white)
                          : const Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class DeletionController extends GetxController {
  final Future<bool> Function() onConfirm;
  late final RxBool isLoading;
  late RxString error;

  DeletionController(this.onConfirm);

  @override
  void onInit() {
    isLoading = false.obs;
    error = "".obs;
    super.onInit();
  }

  void confirm()async{
    try{
      isLoading.value = true;
      var result = await onConfirm();
      isLoading.value = false;
      Get.back(result:result);
    }catch(e){
      error.value = e.toString();
    }
  }
}
