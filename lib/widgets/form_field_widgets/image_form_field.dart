import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageFormField extends FormField<String?> {
  final Future<String> Function(Uint8List) uploader;
  final Future<Uint8List> Function(String) downloader;
  final String title;
  final bool isRequired;



  ImageFormField({
    super.key,
    required this.title,
    required this.uploader,
    required this.downloader,
    this.isRequired = false,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.enabled,
    super.autovalidateMode,
  }) : super(
          builder: (state) {
            bool isLoading = false;
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
                StatefulBuilder(
                  builder: (context, setState) {
                    if (state.value != null) {
                      return Stack(
                        alignment: Alignment.topRight,
                        clipBehavior: Clip.none,
                        children: [
                          FutureBuilder(
                            future: downloader(state.value!),
                            builder: (context, snapshot) {
                              return Container(
                                width: 150,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: snapshot.hasData
                                      ? DecorationImage(
                                          image: MemoryImage(snapshot.data!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: snapshot.hasError
                                    ? const Center(
                                        child: Text("Has Error"),
                                      )
                                    : null,
                              );
                            },
                          ),
                          Positioned(
                            top: -5,
                            right: -20,
                            child: TextButton(
                              onPressed: () {
                                state.didChange(null);
                              },
                              style: const ButtonStyle(
                                shape: MaterialStatePropertyAll(CircleBorder()),
                                fixedSize:
                                    MaterialStatePropertyAll(Size(20, 20)),
                              ),
                              child: const Icon(Icons.clear, size: 16),
                            ),
                          ),
                        ],
                      );
                    }
                    return TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        var pickedFiles = await FilePicker.platform.pickFiles(
                          dialogTitle: "Pick Image",
                          allowCompression: true,
                          allowMultiple: false,
                        );
                        var data = pickedFiles?.files.first.bytes;
                        setState(() {
                          isLoading = false;
                        });
                        if (data == null) return;
                        setState(() {
                          isLoading = true;
                        });
                        String value = await uploader(data);
                        setState(() {
                          isLoading = false;
                        });
                        state.didChange(value);
                      },
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(150, 120)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Get.theme.primaryColorDark.withOpacity(0.8);
                          }
                          return Get.theme.primaryColorDark;
                        }),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: isLoading
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
                ),
              ],
            );
          },
        );
}
