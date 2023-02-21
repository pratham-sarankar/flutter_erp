import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/branch.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    Key? key,
    required this.branch,
    required this.onUpdate,
    required this.onDelete,
    this.canEdit = true,
    this.canDelete = true,
  }) : super(key: key);
  final Branch branch;
  final void Function(Branch) onUpdate;
  final bool canEdit;
  final bool canDelete;
  final void Function(Branch) onDelete;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.none,
      child: Container(
        width: 280,
        height: 330,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 18, right: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        branch.name ?? "Name",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          height: 1.3,
                        ),
                      ),
                      const Spacer(),
                      if (canEdit || canDelete)
                        PopupMenuButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 10,
                          offset: const Offset(0, 20),
                          onSelected: (value) async {
                            switch (value) {
                              case "edit":
                                onUpdate(branch);
                                break;
                              case "delete":
                                onDelete(branch);
                                break;
                            }
                          },
                          itemBuilder: (context) {
                            return <PopupMenuEntry>[
                              if (canEdit)
                                PopupMenuItem(
                                  value: "edit",
                                  height: 35,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 18,
                                        color: Colors.green.shade600,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        "Edit",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              if (canEdit && canDelete)
                                const PopupMenuDivider(height: 1),
                              if (canDelete)
                                PopupMenuItem(
                                  value: "delete",
                                  height: 35,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        size: 18,
                                        color: Colors.red.shade700,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        "Delete",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                            ];
                          },
                          padding: EdgeInsets.zero,
                          child: const Icon(Icons.more_vert, size: 22),
                        )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Stack(
                          children: [
                            Icon(
                              IconlyBold.location,
                              color: context.theme.primaryColorDark
                                  .withOpacity(0.1),
                              size: 15,
                            ),
                            Icon(
                              IconlyLight.location,
                              color: context.theme.primaryColorDark,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          branch.address ?? "-",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Icon(
                            IconlyBold.call,
                            color:
                                context.theme.primaryColorDark.withOpacity(0.1),
                            size: 15,
                          ),
                          Icon(
                            IconlyLight.call,
                            color: context.theme.primaryColorDark,
                            size: 15,
                          ),
                        ],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        branch.phoneNumber ?? "-",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            _Tile(
                title: "Employees",
                count: branch.employeesCount,
                icon: IconlyLight.user2),
            _Tile(
                title: "Customers",
                count: branch.customersCount,
                icon: IconlyLight.user3),
            _Tile(
                title: "Classes",
                count: branch.classesCount,
                icon: IconlyLight.calendar),
            _Tile(
                title: "Courses",
                count: branch.coursesCount,
                icon: IconlyLight.document),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(
      {Key? key, required this.title, required this.count, required this.icon})
      : super(key: key);
  final String title;
  final int count;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          Row(
            children: [
              const SizedBox(width: 16),
              Icon(
                icon,
                size: 18,
                color: Colors.grey.shade800,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                ),
              ),
              Spacer(),
              Text(
                (count == 0 ? "-" : count).toString(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          Spacer(),
          Divider(),
        ],
      ),
    );
  }
}
