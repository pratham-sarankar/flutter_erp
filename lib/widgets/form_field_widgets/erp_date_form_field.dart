import 'package:flutter/material.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_text_form_field.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:resource_manager/data/utils/extensions/validator_extension.dart';

class ErpDateFormField extends FormField<DateTime> {
  final String title;
  final bool isRequired;
  final String? Function(String?)? onValidate;

  ErpDateFormField({
    super.key,
    super.onSaved,
    super.initialValue,
    required this.title,
    this.isRequired = false,
    this.onValidate,
  }) : super(
          builder: (state) {
            return _ErpDateFormField(
              state: state,
              title: title,
              isRequired: isRequired,
            );
          },
          validator: ValidationBuilder(optional: !isRequired)
              .add(onValidate ?? (value) => null)
              .buildDyn(),
        );
}

class _ErpDateFormField extends StatelessWidget {
  _ErpDateFormField(
      {Key? key,
      required this.title,
      this.isRequired = false,
      required this.state})
      : super(key: key);
  final String title;
  final bool isRequired;
  final FormFieldState<DateTime> state;

  @override
  Widget build(BuildContext context) {
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
        TextButton(
          onPressed: () async {
            DateTime? result = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 1000)),
              lastDate: DateTime.now().add(
                const Duration(
                  days: 1000,
                ),
              ),
            );
            if (result == null) return;
            state.didChange(result);
          },
          child: Text(formattedText(state)),
        ),
        if (state.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 0),
            child: Text(
              state.errorText!,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: context.theme.errorColor,
              ),
            ),
          ),
      ],
    );
  }

  String formattedText(FormFieldState<DateTime> state) {
    return state.value == null
        ? "Select Date"
        : DateFormat('d MMM y').format(state.value!);
  }
}
