import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/data/utils/extensions/validator_extension.dart';

class ErpDropDownFormField extends FormField<int?> {
  final List<DropdownMenuItem<int>> items;
  final String? title;
  final bool isRequired;
  final String? Function(String?)? onValidate;

  ErpDropDownFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    required this.items,
    required this.title,
    this.onValidate,
    this.isRequired = false,
  }) : super(
          builder: (state) {
            return _ErpDropDownFormField(
              state: state,
              items: items,
              title: title,
              isRequired: isRequired,
            );
          },
          validator: ValidationBuilder(optional: !isRequired)
              .add(onValidate ?? (value) => null)
              .buildDyn(),
        );
}

class _ErpDropDownFormField extends StatelessWidget {
  const _ErpDropDownFormField(
      {Key? key,
      required this.state,
      required this.items,
      this.title,
      this.isRequired = false})
      : super(key: key);
  final FormFieldState<int?> state;
  final List<DropdownMenuItem<int>> items;
  final String? title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Column(
            children: [
              Row(
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                      title ?? "",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.theme.colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (isRequired)
                    Text(
                      "*",
                      style: context.textTheme.titleMedium!.copyWith(
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
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<int?>(
            isExpanded: true,
            items: [
              DropdownMenuItem(
                value: items.isEmpty ? state.value : null,
                child: const Text(
                  "Select Trainer",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...items,
            ],
            value: state.value,
            onChanged: (selectedValue) {
              state.didChange(selectedValue);
            },
            iconStyleData: IconStyleData(
              icon: Icon(Icons.arrow_drop_down_rounded,
                  size: 25,
                  color: state.value == null ? Colors.grey : Colors.black),
              iconSize: 14,
            ),
            buttonStyleData: ButtonStyleData(
              height: 35,
              padding: const EdgeInsets.only(left: 5, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.theme.outlinedButtonTheme.style!.side!
                      .resolve({})!.color,
                ),
              ),
              elevation: 0,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              padding: null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 8,
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 40,
            ),
          ),
        ),
        if (state.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 0),
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
}
