import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/discount.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/modules/subscriptions/controllers/subscription_form_controller.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_date_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_discount_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_text_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/package_selection_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/customer_selection_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/payment_mode_selection_form_field.dart';

import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class SubscriptionFormView extends GetView<SubscriptionFormController> {
  const SubscriptionFormView({Key? key}) : super(key: key);

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
              "Add Subscription",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 22),
            Flexible(
              child: Form(
                key: controller.formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomerSelectionFormField(
                      initialValue: controller.subscription.value.customer,
                      onSaved: (customer) {
                        controller.subscription.value.customerId = customer?.id;
                      },
                    ),
                    const SizedBox(height: 20),
                    PackageSelectionFormField(
                      initialValue: controller.subscription.value.package,
                      onSaved: (package) {
                        controller.subscription.value.packageId = package?.id;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select a package";
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    PaymentModeSelectionFormField(
                      onSaved: (paymentMode) {
                        controller.subscription.value.modeId = paymentMode?.id;
                      },
                    ),
                    const SizedBox(height: 20),
                    ErpDiscountFormField(
                      title: "Discount",
                      initialValue: controller.subscription.value.discount,
                      onSaved: (value) {
                        controller.subscription.value.discount = value ??
                            Discount(type: DiscountType.none, value: 0);
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ErpDateFormField(
                      initialValue:
                          controller.subscription.value.subscribedAt ??
                              DateTime.now(),
                      onSaved: (dateTime) {
                        controller.subscription.value.subscribedAt = dateTime;
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
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
