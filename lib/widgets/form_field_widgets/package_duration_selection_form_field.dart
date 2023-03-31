import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/package_duration.dart';
import 'package:flutter_erp/app/data/models/payment_mode.dart';
import 'package:flutter_erp/app/data/repositories/package_duration_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_mode_repository.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageDurationSelectionFormField extends FormField<PackageDuration> {
  PackageDurationSelectionFormField({
    super.key,
    super.onSaved,
    super.initialValue,
  }) : super(
          builder: (state) {
            return GetBuilder(
              init: PackageDurationSelectionFieldController(
                initialValue: initialValue?.name,
              ),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select Duration"),
                    const SizedBox(height: 10),
                    TypeAheadFormField<PackageDuration>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller.searchController,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: "1 Month",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
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
                        return await controller.getPackageDurations(pattern);
                      },
                      itemBuilder: (context, PackageDuration packageDuration) {
                        return ListTile(
                          minVerticalPadding: 0,
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          title: Text(packageDuration.title ?? "-"),
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
                            "No mode found",
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
                      onSuggestionSelected: (PackageDuration suggestion) {
                        controller.searchController.text =
                            suggestion.title ?? "-";
                        state.didChange(suggestion);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a duration";
                        }
                        return null;
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
}

class PackageDurationSelectionFieldController extends GetxController {
  late TextEditingController searchController;
  final String? initialValue;

  PackageDurationSelectionFieldController({this.initialValue});

  @override
  void onInit() {
    searchController = TextEditingController(
      text: initialValue,
    );
    super.onInit();
  }

  Future<List<PackageDuration>> getPackageDurations(String pattern) async {
    var result = await Get.find<PackageDurationRepository>().fetch(queries: {
      "search": pattern,
    });
    return result;
  }
}
