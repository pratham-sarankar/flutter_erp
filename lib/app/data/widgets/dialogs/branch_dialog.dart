import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/branch.dart';
import 'package:flutter_erp/app/data/widgets/plus_widgets/plus_form_field.dart';
import 'package:get/get.dart';

class BranchDialog extends StatefulWidget {
  const BranchDialog({Key? key, this.branch}) : super(key: key);
  final Branch? branch;
  @override
  State<BranchDialog> createState() => _BranchDialogState();
}

class _BranchDialogState extends State<BranchDialog> {
  late GlobalKey<FormState> _formKey;
  late Branch branch;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    branch = widget.branch ?? Branch();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        width: Get.width * 0.3,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Add Branch",
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.onBackground,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 22),
            Form(
              key: _formKey,
              child: _basicDetails(),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _basicDetails() {
    return Column(
      children: [
        PlusFormField(
          title: "Name",
          type: TextInputType.name,
          initialText: branch.name,
          onSaved: (value) {
            branch.name = value;
          },
        ),
        const SizedBox(height: 20),
        PlusFormField(
          title: "Address",
          type: TextInputType.streetAddress,
          initialText: branch.address,
          onSaved: (value) {
            branch.address = value;
          },
        ),
        const SizedBox(height: 20),
        PlusFormField(
          title: "Contact number",
          type: TextInputType.phone,
          initialText: branch.phoneNumber,
          onSaved: (value) {
            branch.phoneNumber = value;
          },
        ),
      ],
    );
  }

  Widget _footer() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
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
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  Get.back(result: branch);
                }
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
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
