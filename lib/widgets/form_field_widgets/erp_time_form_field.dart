import 'package:flutter/material.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_text_form_field.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/data/utils/extensions/validator_extension.dart';

class ErpTimeFormField extends FormField<TimeOfDay> {
  final String title;
  final bool isRequired;
  final String? Function(String?)? onValidate;

  ErpTimeFormField({
    super.key,
    super.onSaved,
    super.initialValue,
    required this.title,
    this.isRequired = false,
    this.onValidate,
  }) : super(
          builder: (state) {
            return _ErpTimeFormField(
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

class _ErpTimeFormField extends StatelessWidget {
  const _ErpTimeFormField(
      {Key? key,
      required this.title,
      this.isRequired = false,
      required this.state})
      : super(key: key);
  final String title;
  final bool isRequired;
  final FormFieldState<TimeOfDay> state;

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
            TimeOfDay? result = await showTimePicker(
              context: Get.context!,
              initialTime: state.value ?? TimeOfDay.now(),
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

  String formattedText(FormFieldState<TimeOfDay> state) {
    if (state.value == null) {
      return "00 : 00";
    }
    var hour = state.value?.hour.toString().padLeft(2, "0");
    var minute = state.value?.minute.toString().padLeft(2, "0");
    return "$hour : $minute";
  }
}
