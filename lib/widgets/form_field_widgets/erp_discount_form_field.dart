import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/discount.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/data/utils/extensions/validator_extension.dart';

class ErpDiscountFormField extends FormField<Discount> {
  final String? title;

  ErpDiscountFormField({
    Key? key,
    required super.validator,
    required super.onSaved,
    required super.initialValue,
    this.title,
  }) : super(
          key: key,
          builder: (state) {
            return GetBuilder(
              init: ErpDiscountFieldController(),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null)
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                title ?? "",
                                style:
                                    Get.context!.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Get
                                      .context!.theme.colorScheme.onBackground,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Obx(
                                () => controller.discountType.value !=
                                        DiscountType.none
                                    ? Text(
                                        "*",
                                        style: Get
                                            .context!.textTheme.titleMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red,
                                          height: 1,
                                        ),
                                      )
                                    : Container(),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    TextFormField(
                      controller: controller.discountController,
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.context!.theme.colorScheme.onBackground,
                      ),
                      cursorHeight: 18,
                      decoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.only(top: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextButton(
                            onPressed: () {
                              controller.switchType(state);
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: Obx(() =>
                                Text(controller.discountType.value.title)),
                          ),
                        ),
                      ),
                      onTap: () {},
                      onSaved: (value) {
                        double discountValue = double.tryParse(value!) ?? 0;
                        Discount newDiscount = state.value ??
                            Discount(type: DiscountType.none, value: 0);
                        newDiscount.value = discountValue;
                        state.didChange(newDiscount);
                      },
                      validator: (value) {
                        if (controller.discountType.value !=
                                DiscountType.none &&
                            (value == null || value.isEmpty)) {
                          if (double.tryParse(value ?? "0") == null) {
                            return "Discount value must be a number";
                          }
                          return "Discount value is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 0),
                        child: Text(
                          state.errorText!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Get.context!.theme.errorColor,
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        );
}

class ErpDiscountFieldController extends GetxController {
  late Rx<DiscountType> discountType;
  late TextEditingController discountController;

  @override
  void onInit() {
    discountType = Rx<DiscountType>(DiscountType.none);
    discountController = TextEditingController();
    super.onInit();
  }

  void switchType(FormFieldState<Discount> state) {
    late DiscountType newType;
    switch (discountType.value) {
      case DiscountType.percentage:
        newType = DiscountType.price;
        break;
      case DiscountType.price:
        newType = DiscountType.none;
        break;
      case DiscountType.none:
        newType = DiscountType.percentage;
        break;
    }
    discountType.value = newType;
    double value = double.tryParse(discountController.text) ?? 0;
    state.didChange(Discount(type: newType, value: value));
  }
}
