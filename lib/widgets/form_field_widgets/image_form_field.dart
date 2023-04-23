import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:flutter_erp/app/data/services/file_service.dart';
import 'package:get/get.dart';

class ImageFormField extends FormField<String?> {
  final String title;
  final bool isRequired;

  ImageFormField({
    super.key,
    required this.title,
    this.isRequired = false,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.enabled,
    super.autovalidateMode,
  }) : super(
          builder: (state) => _ImageFormField(
            state: state,
            isRequired: isRequired,
            title: title,
            initialValue: initialValue,
          ),
        );
}

class _ImageFormField extends StatelessWidget {
  const _ImageFormField({
    Key? key,
    required this.state,
    this.title = "Image",
    this.isRequired = false,
    this.initialValue,
  }) : super(key: key);
  final String title;
  final bool isRequired;
  final String? initialValue;
  final FormFieldState<String?> state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _ImageFieldController(
        initialValue: initialValue,
        state: state,
      ),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    title,
                    style: Get.context!.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Get.context!.theme.colorScheme.onBackground,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                if (isRequired)
                  Text(
                    "*",
                    style: Get.context!.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                      height: 1,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                if (state.value != null) {
                  return Stack(
                    alignment: Alignment.topRight,
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          Get.find<FileService>().getUrl(state.value!),
                          width: 150,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -20,
                        child: TextButton(
                          onPressed: () {
                            controller.isLoading.value = false;
                            state.didChange(null);
                          },
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(CircleBorder()),
                            fixedSize: MaterialStatePropertyAll(Size(20, 20)),
                          ),
                          child: const Icon(Icons.clear, size: 16),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Obx(
                    () {
                      return TextButton(
                        onPressed: () async {
                          controller.uploadImage();
                        },
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(150, 120)),
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Get.theme.primaryColorDark
                                  .withOpacity(0.8);
                            }
                            return Get.theme.primaryColorDark;
                          }),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              )
                            : const Icon(
                                CupertinoIcons.camera_circle_fill,
                                size: 60,
                                color: Colors.white,
                              ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class _ImageFieldController extends GetxController {
  late RxBool isLoading;
  final String? initialValue;
  final FormFieldState<String?> state;

  _ImageFieldController({
    this.initialValue,
    required this.state,
  });

  @override
  void onInit() {
    isLoading = (initialValue != null).obs;
    super.onInit();
  }

  void uploadImage() async {
    isLoading.value = true;
    var pickedFiles = await FilePicker.platform.pickFiles(
      dialogTitle: "Pick Image",
      allowCompression: true,
      allowMultiple: false,
    );
    isLoading.value = false;
    Uint8List data;
    if (GetPlatform.isWeb) {
      data = pickedFiles!.files.first.bytes!;
    } else {
      var path = pickedFiles?.files.first.path;
      if (path == null) return;
      File file = File(path);
      data = await file.readAsBytes();
    }
    isLoading.value = true;
    String value = await Get.find<FileService>().uploadFile(data);
    isLoading.value = false;
    state.didChange(value);
  }
}
