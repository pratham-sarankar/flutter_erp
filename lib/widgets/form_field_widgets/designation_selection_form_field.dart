import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignationSelectionFormField extends FormField<Designation> {
  final bool isRequired;

  DesignationSelectionFormField(
      {super.key,
      super.onSaved,
      required String? title,
      this.isRequired = false})
      : super(
          builder: (state) {
            return GetBuilder(
              init: DesignationSelectionFieldController(),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              title ?? "Select Designation",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Get.theme.colorScheme.onBackground,
                              ),
                            ),
                            const SizedBox(width: 4),
                            if (isRequired)
                              Text(
                                "*",
                                style: Get.textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red,
                                  height: 1,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    TypeAheadFormField<Designation>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller.designationController,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: "Manager",
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await controller.getDesignations(pattern);
                      },
                      itemBuilder: (context, Designation designation) {
                        return ListTile(
                          minVerticalPadding: 0,
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          title: Text(designation.getName()),
                          subtitle: Text(designation.employeesCount.toString()),
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
                            "No customers found",
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
                      onSuggestionSelected: (Designation suggestion) {
                        controller.designationController.text =
                            suggestion.getName();
                        state.didChange(suggestion);
                      },
                      validator: (value) {
                        if (isRequired && (value == null || value.isEmpty)) {
                          return "Please select a designation";
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

class DesignationSelectionFieldController extends GetxController {
  final designationController = TextEditingController();
  final customer = Rx<Customer?>(null);

  @override
  void onInit() {
    super.onInit();
    designationController.addListener(() {
      customer.value = null;
    });
  }

  Future<List<Designation>> getDesignations(String pattern) async {
    final designations = await Get.find<DesignationRepository>().fetch(
      queries: {
        "search": pattern,
      },
    );
    return designations;
  }
}
