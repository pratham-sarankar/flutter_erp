import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerSelectionFormField extends FormField<Customer> {
  CustomerSelectionFormField({
    super.key,
    super.onSaved,
    super.initialValue,
    String? title,
  }) : super(builder: (state) {
          return GetBuilder(
            init: CustomerSelectionFieldController(
                initialValue: initialValue?.name),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? "Search Customer"),
                  const SizedBox(height: 8),
                  TypeAheadFormField<Customer>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: controller.customerController,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: "John Doe",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
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
                      return await controller.getCustomers(pattern);
                    },
                    itemBuilder: (context, Customer customer) {
                      return ListTile(
                        minVerticalPadding: 0,
                        dense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        title: Text(customer.name),
                        subtitle:
                            Text(customer.email ?? customer.phoneNumber ?? "-"),
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
                    onSuggestionSelected: (Customer suggestion) {
                      controller.customerController.text = suggestion.name;
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

class CustomerSelectionFieldController extends GetxController {
  late final TextEditingController customerController;

  final customer = Rx<Customer?>(null);
  final String? initialValue;

  CustomerSelectionFieldController({this.initialValue});

  @override
  void onInit() {
    super.onInit();
    customerController = TextEditingController(text: initialValue);
  }

  Future<List<Customer>> getCustomers(String pattern) async {
    final customers = await Get.find<CustomerRepository>().fetch(
      queries: {
        "search": pattern,
      },
    );
    return customers;
  }
}
