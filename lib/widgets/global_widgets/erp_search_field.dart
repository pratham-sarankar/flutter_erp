import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ErpSearchField extends StatelessWidget {
  const ErpSearchField(
      {super.key,
      this.controller,
      this.isConstrained = true,
      required this.onUpdate});

  final Function(String) onUpdate;
  final TextEditingController? controller;
  final bool isConstrained;

  @override
  Widget build(BuildContext context) {
    var searchField = CupertinoSearchTextField(
      controller: controller,
      style: GoogleFonts.poppins(
        fontSize: 15,
      ),
      onChanged: (value) {
        onUpdate(value);
      },
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: context.theme.dividerTheme.color ?? Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      placeholderStyle: GoogleFonts.poppins(
        fontSize: 15,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: const Icon(CupertinoIcons.search, size: 18),
      prefixInsets: const EdgeInsets.only(left: 10, right: 0),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    );
    return isConstrained
        ? ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 150,
              maxWidth: 200,
            ),
            child: searchField)
        : searchField;
  }
}
