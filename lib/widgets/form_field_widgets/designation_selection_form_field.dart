import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignationSelectionFormField extends FormField<Designation> {
  DesignationSelectionFormField({super.key, super.onSaved})
      : super(builder: (state) {
    return GetBuilder(
      init: DesignationSelectionFieldController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Designation"),
            const SizedBox(height: 8),
            TypeAheadFormField<Designation>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: controller.designationController,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: "Manager",
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
                return await controller.getDesignations(pattern);
              },
              itemBuilder: (context, Designation designation) {
                return ListTile(
                  minVerticalPadding: 0,
                  dense: true,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10),
                  title: Text(designation.getName()),
                  subtitle:
                  Text(designation.employeesCount.toString()),
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
                controller.designationController.text = suggestion.getName();
                state.didChange(suggestion);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a customer";
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  });
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
