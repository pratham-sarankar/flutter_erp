import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/discount.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/modules/purchases/controllers/purchase_form_controller.dart';
import 'package:flutter_erp/app/modules/subscriptions/controllers/subscription_form_controller.dart';
import 'package:flutter_erp/widgets/form_field_widgets/course_selection_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_date_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_discount_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_text_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/package_selection_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/customer_selection_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/payment_mode_selection_form_field.dart';

import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class PurchaseFormView extends GetView<PurchaseFormController> {
  const PurchaseFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        width: Get.width * 0.5,
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
              "Add Purchase",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 22),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  CustomerSelectionFormField(
                    initialValue: controller.purchase.value.customer,
                    onSaved: (customer) {
                      controller.purchase.value.customerId = customer?.id;
                    },
                  ),
                  const SizedBox(height: 20),
                  CourseSelectionFormField(
                    initialValue: controller.purchase.value.course,
                    onSaved: (course) {
                      controller.purchase.value.courseId = course?.id;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select a course";
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  PaymentModeSelectionFormField(
                    onSaved: (paymentMode) {
                      controller.purchase.value.modeId = paymentMode?.id;
                    },
                  ),
                  const SizedBox(height: 20),
                  ErpDiscountFormField(
                    title: "Discount",
                    initialValue: controller.purchase.value.discount,
                    onSaved: (value) {
                      controller.purchase.value.discount =
                          value ?? Discount(type: DiscountType.none, value: 0);
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ErpDateFormField(
                    initialValue:
                        controller.purchase.value.purchasedAt ?? DateTime.now(),
                    onSaved: (dateTime) {
                      controller.purchase.value.purchasedAt = dateTime;
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _footer() {
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
                      color: Get.theme?.colorScheme.error ?? Colors.red,
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
                      controller.submit();
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
                              "Save",
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
