import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/branch.dart';
import 'package:get/get.dart';

class BranchSelectionDialog extends StatefulWidget {
  const BranchSelectionDialog({Key? key, required this.branches})
      : super(key: key);
  final List<Branch> branches;
  @override
  State<BranchSelectionDialog> createState() => _BranchSelectionDialogState();
}

class _BranchSelectionDialogState extends State<BranchSelectionDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        width: Get.width * 0.3,
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.5,
        ),
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
                  "Branches",
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.onBackground,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(child: _branchesList()),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _branchesList() {
    return ListView.separated(
      itemCount: widget.branches.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Get.back(result: widget.branches[index]);
        },
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.zero,
        title: Text(widget.branches[index].name ?? "-"),
        subtitle: Text(widget.branches[index].address ?? "-"),
      ),
      separatorBuilder: (context, index) => const Divider(),
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
          ],
        ),
      ],
    );
  }
}
