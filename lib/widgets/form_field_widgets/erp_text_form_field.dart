import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/utils/extensions/form_validator.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ErpTextFormField extends StatelessWidget {
  const ErpTextFormField({
    Key? key,
    this.title,
    this.initialValue,
    this.isRequired = false,
    this.onValidate,
    this.onSaved,
    this.hintText,
    this.onSubmitted,
    this.enabled = true,
    this.isMultiline = false,
    this.controller,
  }) : super(key: key);
  final String? title;
  final String? initialValue;
  final bool isRequired;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onSaved;
  final void Function(String?)? onSubmitted;
  final String? hintText;
  final bool enabled;
  final bool isMultiline;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          style: TextStyle(
            fontSize: 14,
            color: context.theme.colorScheme.onBackground,
          ),
          enabled: enabled,
          onFieldSubmitted: onSubmitted,
          cursorHeight: 18,
          decoration: InputDecoration(
            isDense: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
          ),
          maxLines: isMultiline ? null : 1,
          onTap: () {},
          onSaved: onSaved,
          validator: ValidationBuilder(optional: !isRequired)
              .add(onValidate ?? (value) => null)
              .buildDyn(),
        ),
      ],
    );
  }
}
