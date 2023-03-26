import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/data/models/employee.dart';
import '../../app/data/models/employee.dart';
import '../../app/data/models/employee.dart';
import '../../app/data/models/employee.dart';
import '../../app/data/models/employee.dart';
import '../../app/data/models/employee.dart';

class TrainerSelectionFormField extends FormField<Employee> {
  TrainerSelectionFormField({super.key, super.onSaved, required String title})
      : super(builder: (state) {
    return GetBuilder(
      init: TrainerSelectionFieldController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Trainer"),
            const SizedBox(height: 8),
            TypeAheadFormField<Employee>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: controller.trainerController,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: "Trainer",
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
                return await controller.getEmployees(pattern);
              },
              itemBuilder: (context, Employee employee) {
                return ListTile(
                  minVerticalPadding: 0,
                  dense: true,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10),
                  title: Text(employee.getName()),

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
                    "No trainers found",
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
              onSuggestionSelected: (Employee suggestion) {
                controller.trainerController.text = suggestion.getName();
                state.didChange(suggestion);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a trainer";
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

class TrainerSelectionFieldController extends GetxController {
  final trainerController = TextEditingController();
  final customer = Rx<Customer?>(null);

  @override
  void onInit() {
    super.onInit();
    trainerController.addListener(() {
      customer.value = null;
    });
  }

  Future<List<Employee>> getEmployees(String pattern) async {
    final trainers = await Get.find<EmployeeRepository>().fetch(
      queries: {
        "search": pattern,
        "designation_key":"trainer",
      },
    );
    return trainers;
  }
}
