import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlusDropDown extends StatefulWidget {
  const PlusDropDown({
    Key? key,
    required this.items,
    required this.onChanged,
    this.initialValue,
    this.validator,
    this.onSaved,
  }) : super(key: key);
  final List<DropdownMenuItem<int>> items;
  final int? initialValue;
  final Function(int?)? onChanged;
  final String? Function(int?)? validator;
  final void Function(int?)? onSaved;

  @override
  State<PlusDropDown> createState() => _PlusDropDownState();
}

class _PlusDropDownState extends State<PlusDropDown> {
  late int? value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: IntrinsicWidth(
        child: DropdownButtonFormField2<int>(
          isExpanded: true,
          items: widget.items,
          value: value,
          onChanged: (selectedValue) {
            if (widget.onChanged == null) return;
            widget.onChanged!(selectedValue);
            setState(() {
              value = selectedValue;
            });
          },
          icon: Icon(Icons.arrow_drop_down_rounded,
              size: 25, color: value == null ? Colors.grey : Colors.black),
          iconSize: 14,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
          buttonHeight: 35,
          buttonPadding: const EdgeInsets.only(left: 5, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.theme.outlinedButtonTheme.style!.side!
                  .resolve({})!.color,
            ),
          ),
          buttonElevation: 0,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(0, 0),
          validator: widget.validator,
          onSaved: widget.onSaved,
        ),
      ),
    );
  }
}
