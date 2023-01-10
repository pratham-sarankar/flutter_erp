import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PlusFormField extends StatefulWidget {
  const PlusFormField({
    Key? key,
    required this.title,
    this.isRequired = false,
    this.onValidate,
    this.type = TextInputType.name,
    this.onSaved,
    this.hintText,
    this.initialText,
    this.controller,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final bool isRequired;
  final bool enabled;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onSaved;
  final TextInputType type;
  final TextEditingController? controller;
  final String? hintText;
  final String? initialText;

  @override
  State<PlusFormField> createState() => _PlusFormFieldState();
}

class _PlusFormFieldState extends State<PlusFormField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Opacity(
              opacity: 0.8,
              child: Text(
                widget.title,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.theme.colorScheme.onBackground,
                ),
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
        TextFormField(
          controller: _controller,
          keyboardType: widget.type,
          obscureText: widget.type == TextInputType.visiblePassword,
          style: TextStyle(
            fontSize: 14,
            color: context.theme.colorScheme.onBackground,
          ),
          enabled: widget.enabled,
          cursorHeight: 18,
          decoration: InputDecoration(
            isDense: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: widget.hintText ?? "",
          ),
          onTap: () {
            if (widget.type == TextInputType.datetime) {
              _pickDate();
            }
          },
          onSaved: widget.onSaved,
          validator: widget.onValidate,
        ),
      ],
    );
  }

  void _pickDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 100),
      ),
    );
    if (date != null) {
      var formatter = DateFormat("dd-M-yyyy");
      String value = formatter.format(date);
      _controller.text = value;
    }
  }
}
