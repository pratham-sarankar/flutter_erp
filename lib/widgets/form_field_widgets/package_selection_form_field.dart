import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/models/package.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageSelectionFormField extends FormField<Package> {
  PackageSelectionFormField({super.key, super.onSaved, super.validator})
      : super(
          builder: (state) {
            return GetBuilder(
              init: PackageSelectionFieldController(),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select Class"),
                    const SizedBox(height: 8),
                    TypeAheadFormField<Class>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller.classController,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.poppins(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 1,
                            ),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                            bottom: 12,
                            top: 12,
                            right: 10,
                            left: 10,
                          ),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await controller.getClasses(pattern);
                      },
                      itemBuilder: (context, Class classDetails) {
                        return ListTile(
                          minVerticalPadding: 0,
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          title: Text(classDetails.name),
                          subtitle: Text(classDetails.description ?? "-",
                              maxLines: 1),
                        );
                      },
                      hideOnEmpty: false,
                      getImmediateSuggestions: true,
                      keepSuggestionsOnLoading: true,
                      hideOnLoading: false,
                      animationStart: 1,
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 1,
                        constraints: const BoxConstraints(
                          maxHeight: 300,
                        ),
                      ),
                      noItemsFoundBuilder: (context) {
                        return Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "No classes found",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context) {
                        return Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (Class suggestion) {
                        controller.onChanged(suggestion);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a class";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () {
                        if (controller.loadingPackages.value) {
                          return Row(
                            children: const [
                              SizedBox(width: 4),
                              CupertinoActivityIndicator(),
                              SizedBox(width: 8),
                              Text("Loading packages...")
                            ],
                          );
                        }
                        return Wrap(
                          spacing: 10,
                          children: [
                            for (var package in controller.packages)
                              IntrinsicWidth(
                                child: RadioMenuButton(
                                  value: package.id,
                                  groupValue:
                                      controller.selectedPackage?.value.id ??
                                          -1,
                                  onChanged: (value) {
                                    controller.selectPackage(package);
                                    state.didChange(
                                        controller.selectedPackage.value);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey.shade100),
                                  ),
                                  child: Text(
                                    package.name ?? "-",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        );
                      },
                    ),
                    if (state.hasError &&
                        controller.classController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          state.errorText ?? "",
                          style: TextStyle(
                            color: Get.theme.colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      )
                  ],
                );
              },
            );
          },
        );
}

class PackageSelectionFieldController extends GetxController {
  final classController = TextEditingController();
  late RxList<Package> packages;
  late RxBool loadingPackages;
  late Rx<Package> selectedPackage;

  @override
  void onInit() {
    loadingPackages = false.obs;
    packages = RxList<Package>([]);
    selectedPackage = Get.find<PackageRepository>().empty.obs;
    super.onInit();
  }

  Future<List<Class>> getClasses(String pattern) async {
    return await Get.find<ClassRepository>().fetch(
      queries: {
        "search": pattern,
      },
    );
  }

  Future onChanged(Class suggestion) async {
    classController.text = suggestion.name;
    loadingPackages.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    final packages = await Get.find<PackageRepository>().fetch(
      queries: {
        "classId": suggestion.id,
      },
    );
    loadingPackages.value = false;
    this.packages.value = packages;
  }

  void selectPackage(Package package) {
    selectedPackage.value = package;
  }
}
