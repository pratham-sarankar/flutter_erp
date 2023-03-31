import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/utils/extensions/form_validator.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ErpPasswordFormField extends StatefulWidget {
  const ErpPasswordFormField({
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
  State<ErpPasswordFormField> createState() => _ErpPasswordFormFieldState();
}

class _ErpPasswordFormFieldState extends State<ErpPasswordFormField> {
  late bool isObscure;

  @override
  void initState() {
    isObscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null)
          Column(
            children: [
              Row(
                children: [
                  Text(
                    widget.title ?? "",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (widget.isRequired)
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
          controller: widget.controller,
          initialValue: widget.initialValue,
          style: TextStyle(
            fontSize: 14,
            color: context.theme.colorScheme.onBackground,
          ),
          enabled: widget.enabled,
          onFieldSubmitted: widget.onSubmitted,
          // cursorHeight: 50,
          decoration: InputDecoration(
            isDense: true,
            isCollapsed: true,
            contentPadding:
                const EdgeInsets.only(bottom: 0, left: 10, right: 10, top: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: widget.hintText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              child: isObscure
                  ? const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
            ),
          ),
          obscureText: isObscure,
          maxLines: widget.isMultiline ? null : 1,
          onTap: () {},
          onSaved: widget.onSaved,
          validator: ValidationBuilder(optional: !widget.isRequired)
              .add(widget.onValidate ?? (value) => null)
              .buildDyn(),
        ),
      ],
    );
  }
}
